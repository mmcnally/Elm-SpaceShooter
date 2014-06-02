import Keyboard

-- x = current x location
-- y = current y location
-- vx = current x velocity
-- vy = current y velocity
-- angle = current angle of ship in radians, 0 is facing to the right
type GameState = { x: Float, y: Float, vx: Float, vy: Float, angle: Float, time: Float, shoot: Bool, bullet: BulletState }
initalGameState = { x = 0, y = 0, vx = 0, vy = 0, angle = (pi/2), time = 0, shoot = False, bullet = initalBulletState }

type BulletState = { x: Float, y: Float, vx: Float, vy: Float, angle: Float, birthTime: Float, shot: Bool }
initalBulletState = { x = 0, y = 0, vx = 0, vy = 0, angle = (pi/2), birthTime = 0, shot = False }

data Input = Forward |
             Backward |
             RotCCW |
             RotCW |
             Shoot |
             NoInput
             
rotateShip : GameState -> Float -> GameState
rotateShip g r = 
    let newAngle = g.angle + r in
    if | newAngle > 2*pi -> { g | angle <- newAngle - 2*pi } 
       | newAngle < 0    -> { g | angle <- newAngle + 2*pi } 
       | otherwise       -> { g | angle <- newAngle }

update: (Input, Time) -> GameState -> GameState
update (i, t) g = 
             let tempBullet = g.bullet
                 resetBullet = { initalBulletState | x <- g.x, y <- g.y, vx <- g.vx, vy <- g.vy}
                 bShot = { tempBullet | x <- tempBullet.vx + tempBullet.x, y <- tempBullet.vy + tempBullet.y}
                 b = { tempBullet | x <- g.x, y <- g.y, vx <- g.vx, vy <- g.vy}
                 b' = { b | shot <- True, birthTime <- g.time, x <- g.x, y <- g.y, vx <- g.vx + 17, vy <- g.vy - 13, angle <- g.angle}
                 g' = { g | time <- g.time + t, shoot <- False, bullet <- b }
             in
             case i of 
             Forward -> if | b.shot == True && g.time - b.birthTime > 2000 -> { g' | shoot <- False, 
                                                                                    bullet <- resetBullet, 
                                                                                         x <- (g'.x + 1 * cos(g'.angle)),
                                                                                         y <- (g'.y + 1 * sin(g'.angle)) }
                           | b.shot == True                                -> { g' | bullet <- bShot, 
                                                                                          x <- (g'.x + 1 * cos(g'.angle)),
                                                                                          y <- (g'.y + 1 * sin(g'.angle)) }
                           | otherwise -> { g' | x <- (g'.x + 1 * cos(g'.angle)),
                                                 y <- (g'.y + 1 * sin(g'.angle)) }
             Backward -> if | b.shot == True && g.time - b.birthTime > 2000 -> { g' | shoot  <- False, 
                                                                                      bullet <- resetBullet, 
                                                                                           x <- (g'.x - 1 * cos(g'.angle)),
                                                                                           y <- (g'.y - 1 * sin(g'.angle)) }
                            | b.shot == True                                -> { g' | bullet <- bShot,
                                                                                           x <- (g'.x - 1 * cos(g'.angle)),
                                                                                           y <- (g'.y - 1 * sin(g'.angle)) }
                            | otherwise -> { g' | x <- (g'.x - 1 * cos(g'.angle)),
                                                  y <- (g'.y - 1 * sin(g'.angle)) }
             RotCCW -> if | b.shot == True && g.time - b.birthTime > 2000 -> rotateShip { g' | shoot <- False, bullet <- resetBullet } (pi/60)
                          | b.shot == True                                -> rotateShip { g' | bullet <- bShot } (pi/60)
                          | otherwise -> rotateShip g' (pi/60)
             RotCW -> if | b.shot == True && g.time - b.birthTime > 2000 -> rotateShip { g' | shoot <- False, bullet <- resetBullet } (-pi/60)
                         | b.shot == True                                -> rotateShip { g' | bullet <- bShot } (-pi/60)
                         | otherwise -> rotateShip g' (-pi/60)
             Shoot -> if | b.shot == False                                 -> { g' | shoot <- True, bullet <- b' }
                         | b.shot == True && g.time - b.birthTime > 2000   -> { g' | shoot <- False, bullet <- resetBullet }
                         | otherwise                                       -> { g' | shoot <- True, bullet <- bShot }
             NoInput -> if | b.shot == True && g.time - b.birthTime > 2000 -> { g' | shoot <- False, bullet <- resetBullet }
                           | b.shot == True                                -> { g' | bullet <- bShot }
                           | otherwise                                     -> { g' | bullet <- b }
             
-- foldp : (currentInput -> previousGameState -> currentGameState) -> initalGameState -> Signal userInput -> Signal currentGameState

delta = (fps 60)

stateSignal : Signal GameState
stateSignal = foldp update initalGameState ( (,) <~ (input <~ ( (,) <~ (sampleOn delta Keyboard.arrows) ~ (sampleOn delta Keyboard.space) ) ) ~ delta)
             
input : ({x: Int, y: Int}, Bool) -> Input
input (arr, boo) = 
    if | arr.x == -1 -> RotCCW
       | arr.x == 1 -> RotCW
       | arr.y == -1 -> Backward
       | arr.y == 1 -> Forward
       | boo -> Shoot
       | otherwise -> NoInput
       

-- asText : a -> Element
-- Signal Element
-- lift : (a -> Element) -> Signal a -> Signal Element

--                asText
--            |----------------|
-- aaaaaaa -->| a   -> Element | -->EEEEEE
--            |----------------|

-- Keyboard.arrows : Signal {x : Int, y : Int}
-- (input <~ Keyboard.arrows) : Signal Input

render : GameState -> Element
render state = 
    let debug = asText state
        form = filled blue (ngon 3 20) |> rotate state.angle |> move (state.x, state.y)
        display = collage 400 400 [form]
     in flow down [debug, display]

main : Signal Element
main = render <~ stateSignal
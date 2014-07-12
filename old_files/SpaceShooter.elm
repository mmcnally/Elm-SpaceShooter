module SpaceShooter where

import Keyboard

-- x = current x location
-- y = current y location
-- vx = current x velocity
-- vy = current y velocity
-- angle = current angle of ship in radians, 0 is facing to the right
type GameState = { x: Float, 
                   y: Float, 
                   vx: Float, 
                   vy: Float, 
                   angle: Float, 
                   time: Float, 
                   shoot: Bool, 
                   bullet: BulletState, 
                   prevInput: [Input], 
                   acc: Float }


type BulletState = { x: Float, 
                     y: Float, 
                     vx: Float, 
                     vy: Float, 
                     angle: Float, 
                     birthTime: Float, 
                     shot: Bool }

initalGameState = { x = 0, 
                    y = 0, 
                    vx = 0, 
                    vy = 0, 
                    angle = (pi/2), 
                    time = 0, 
                    shoot = False, 
                    bullet = initalBulletState, 
                    prevInput = [], 
                    acc = 1 }

initalBulletState = { x = 0, 
                      y = 0, 
                      vx = 0, 
                      vy = 0, 
                      angle = (pi/2), 
                      birthTime = 0, 
                      shot = False }

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

member : [Input] -> Input -> Bool
member inputs toCheck = any (\c -> toCheck == c) inputs

physics : Time -> [Input] -> GameState -> GameState
physics t inputs g =
    let tempBullet = g.bullet
        resetBullet = { initalBulletState | x <- g.x, y <- g.y, vx <- g.vx, vy <- g.vy}
        b = { tempBullet | x <- g.x, y <- g.y, vx <- g.vx, vy <- g.vy }
        bShot = { tempBullet | x <- tempBullet.vx + tempBullet.x, y <- tempBullet.vy + tempBullet.y}
        b' = { b | shot <- True, birthTime <- g.time, x <- g.x, y <- g.y, vx <- g.vx + 17, vy <- g.vy - 13, angle <- g.angle}
        g' = { g | time <- g.time + t,
                   x <- g.x + g.vx,
                   y <- g.y + g.vy,
                   prevInput <- inputs,
                   acc <- if inputs `member` Forward ||
                             inputs `member` Backward
                          then g.acc
                          else 0,
                   bullet <- b }
    in if | b.shot == True && g.time - b.birthTime > 2000 -> { g' | shoot <- False, 
                                                                              bullet <- resetBullet }
          | b.shot == True -> { g' | bullet <- bShot }
          | otherwise -> g'

-- map : (a -> b) -> [a] -> [b]

-- fold : (a -> b -> b) -> b -> [a] -> [b]

-- map update : [(Input, Time)] -> [GameState]
update' : ([Input], Time) -> GameState -> GameState
update' (inputs, t) g = 
    let g' = physics t inputs g in
    updateHelper inputs g'

updateHelper : [Input] -> GameState -> GameState
updateHelper inputs state =
    if | isEmpty inputs -> state
       | otherwise -> let first = head inputs
                          rest = tail inputs
                          state' = update first state
                      in updateHelper rest state'

update: Input -> GameState -> GameState
update i g = 
    let tempBullet = g.bullet
        -- b is the bullet when it is in the chamber of the gun yet has not been calculated to have been not shot. (One frame)
        b = { tempBullet | x <- g.x, y <- g.y, vx <- g.vx, vy <- g.vy}
        -- b' is the bullet when it is first shot 
        b' = { shot = True, birthTime = g.time, x = g.x, y = g.y, vx = g.vx + 17, vy = g.vy - 13, angle = g.angle}
                 -- g' is the new gamestate
    in
      case i of 
        Forward -> { g | vx <- g.acc * cos(g.angle),
                          vy <- g.acc * sin(g.angle),
                          acc <- if g.prevInput `member` Forward && (g.acc < 3) 
                                 then g.acc + 0.2 else 0 }
        Backward -> { g | vx <- g.acc * -1*cos(g.angle),
                           vy <- g.acc * -1*sin(g.angle),
                           acc <- if g.prevInput `member` Backward && (g.acc < 3) 
                                  then g.acc + 0.2 
                                  else 0}
        RotCCW -> rotateShip g (pi/60)
        RotCW -> rotateShip g (-pi/60)
        Shoot -> if | b.shot == False -> { g | shoot <- True, bullet <- b' }
                    | otherwise -> g
        NoInput -> g 
             
-- foldp : (currentInput -> previousGameState -> currentGameState) -> initalGameState -> Signal userInput -> Signal currentGameState

delta = (fps 60)

stateSignal : Signal GameState
stateSignal = foldp update' initalGameState ( (,) <~ (input' <~ Keyboard.keysDown ) ~ delta)

leftArrow = 37
rightArrow = 39
upArrow = 38
downArrow = 40
spaceBar = 32

-- map : (a -> b) -> [a] -> [b]

input' : [Keyboard.KeyCode] -> [Input]
input' codes = map input codes

input : Keyboard.KeyCode -> Input
input keycode = 
    if | keycode == leftArrow -> RotCCW
       | keycode == rightArrow -> RotCW
       | keycode == downArrow -> Backward
       | keycode == upArrow -> Forward
       | keycode == spaceBar -> Shoot
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
        display = collage 500 500 [form]
     in flow down [display, debug]

main : Signal Element
main = render <~ stateSignal
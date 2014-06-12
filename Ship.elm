module Ship where
import Playground.Input (..)
import Keyboard.Keys as Keys

type Ship = { x : Float, y : Float,
              vx : Float, vy : Float,
              color : ShipColor, speed : Float,
              size : Float, angle: Float,
              accelerate: Float }
              
type ShipColor = { body : Color, window : Color, body2 : Color }

shipColor = { body = blue, window = grey, body2 = green } 

initialShip : Ship
initialShip = { x = 0, 
                y = 0, 
                vx = 0, 
                vy = 0, 
                color = shipColor, 
                speed = 0,
                size = 20,
                angle = pi/2,
                accelerate = 0 }

render : Ship -> Form
render {x, y, color, size, angle} = 
  group [ ngon 3 size |> filled color.body,
          ngon 3 (size * 0.7) |> filled color.window |> move (size * 0.1, 0),
          ngon 3 (size * 0.2) |> filled color.body2 ] |> rotate angle |> move (x, y)


maxSpeed = 5

-- accelerates ship if accelerate is true
-- otherwise it slows down ship
accelerate: Ship -> Ship
accelerate ship = 
    let dir = ship.speed / (abs ship.speed) in
    if | (ship.accelerate /= 0) && (abs ship.speed) < (abs ship.accelerate) -> { ship | speed <- ship.accelerate }
       | (ship.accelerate /= 0) -> { ship | speed <- if (abs ship.speed) < maxSpeed
                                              then ship.speed + ((abs ship.speed) * ship.accelerate)
                                              else dir*maxSpeed }
       | otherwise -> { ship | speed <- if | (abs ship.speed) < 0.025 -> 0
                             | otherwise -> ship.speed - (ship.speed * 0.005) } 
 
physics : Ship -> Ship
physics ship = 
     let ship' = accelerate ship
     in { ship' | x <- ship'.x + (ship'.vx * ship'.speed),
                  y <- ship'.y + (ship'.vy * ship'.speed) }

-- adjusts ship angle based on arrow keys pressed
adjustAngle: Ship -> Float -> Ship
adjustAngle ship num = 
    let ship' = { ship | angle <- if | ship.angle > (2 * pi) -> 0
                                     | ship.angle < 0 -> 2 * pi
                                     | otherwise -> ship.angle}
    in { ship' | angle <- if num > 0
                          then ship'.angle - (pi/30)
                          else ship'.angle + (pi/30) }


update : Input -> Ship -> Ship
update input ship =
    case input of
      Key key ->
        if | key `Keys.equal` Keys.arrowUp -> 
                      { ship | vx <- cos(ship.angle),
                                vy <- sin(ship.angle),
                                accelerate <- 0.25 }
           | key `Keys.equal` Keys.arrowDown -> 
                      { ship | vx <- cos(ship.angle),
                               vy <- sin(ship.angle),
                               accelerate <- (-0.25) }
           | key `Keys.equal` Keys.arrowLeft -> 
                                adjustAngle ship (-1)
           | key `Keys.equal` Keys.arrowRight ->
                                adjustAngle ship (1)

           | otherwise -> ship
      Passive t ->  let ship' = physics ship
                    in { ship' | accelerate <- 0 }
      otherwise -> ship
  
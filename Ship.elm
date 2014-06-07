module Ship where
import Playground.Input (..)
import Keyboard.Keys as Keys
-- import GameState (..)

type Ship = { x : Float, y : Float,
              vx : Float, vy : Float,
              color : ShipColor, speed : Float,
              size : Float, angle: Float,
              accelerate: Bool }
              
type ShipColor = { body : Color, window : Color, body2 : Color }

shipColor = { body = blue, window = grey, body2 = green } 

enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 
enemy: Ship
enemy = { x = 0,
          y = 0,
          vx = 0,
          vy = 0,
          color = enemyShipColor,
          speed = 2,
          size = 10,
          angle = 0,
          accelerate = False }

initialShip : Ship
initialShip = { x = 0, 
                y = 0, 
                vx = 0, 
                vy = 0, 
                color = shipColor, 
                speed = 0,
                size = 20,
                angle = pi/2,
                accelerate = False }

render : Ship -> Form
render {x, y, color, size, angle} = 
  group [ ngon 3 size |> filled color.body,
          ngon 3 (size * 0.7) |> filled color.window |> move (size * 0.1, 0),
          ngon 3 (size * 0.2) |> filled color.body2 ] |> rotate angle |> move (x, y)



-- accelerates ship if accelerate is true
-- otherwise it slows down ship
accelerate: Ship -> Ship
accelerate ship = 
    if | ship.accelerate && ship.speed < 1 -> { ship | speed <- 1 }
       | ship.accelerate -> { ship | speed <- if ship.speed < 10 
                                              then ship.speed + 0.5 
                                              else ship.speed }
       | otherwise -> { ship | speed <- if ship.speed < 0.1
                                        then 0
                                        else  ship.speed - (ship.speed * 0.1) }

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


-- enemyAI: Gamestate -> Ship -> Ship
-- enemyAI state enemyShip = enemyShip


moveEnemies: Float -> Float -> Ship -> Ship
moveEnemies x y enemyShip = { enemyShip | x <- enemyShip.x + 5,
                                          y <- enemyShip.y - 5 }

update : Input -> Ship -> Ship
update input ship =
  -- let enemyShip' = map moveEnemies ship.x ship.y enemyShip
  -- in 
    case input of
      Key key ->
        if | key `Keys.equal` Keys.arrowUp -> 
                      { ship | vx <- cos(ship.angle),
                                vy <- sin(ship.angle),
                                accelerate <- True }
           | key `Keys.equal` Keys.arrowDown -> 
                      { ship | speed <- ship.speed / 4 }
           | key `Keys.equal` Keys.arrowLeft ->
                                adjustAngle ship (-1)
           | key `Keys.equal` Keys.arrowRight ->
                                adjustAngle ship (1)

           | otherwise -> ship
      Passive t ->  let ship' = physics ship
                    in { ship' | accelerate <- False }
      otherwise -> ship

module Ship where
import Playground.Input (..)
import Keyboard.Keys as Keys

type Ship = { x : Float, y : Float,
              vx : Float, vy : Float,
              color : ShipColor, speed : Float,
              size : Float }
              
type ShipColor = { body : Color, window : Color, body2 : Color }

shipColor = { body = blue, window = grey, body2 = green } 

enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 

enemy = { x = 0,
          y = 0,
          vx = 0,
          vy = 0,
          color = enemyShipColor,
          speed = 1,
          size = 10 }

initialShip : Ship
initialShip = { x = 0, 
                y = 0, 
                vx = 0, 
                vy = 0, 
                color = shipColor, 
                speed = 2,
                size = 20 }

render : Ship -> Form
render {x, y, color, size} = group [ ngon 3 size |> filled color.body |> move (x, y),
                                     ngon 3 (size * 0.7) |> filled color.window |> move ( (x + (size * 0.1)), y),
                                     ngon 3 (size * 0.2) |> filled color.body2 |> move (x, y) ]

physics : Ship -> Ship
physics ship = { ship | x <- ship.x + ship.vx,
                        y <- ship.y + ship.vy }

update : Input -> Ship -> Ship
update input ship =
    case input of
      Key key -> if | key `Keys.equal` Keys.arrowLeft -> 
                      { ship | x <- ship.x - ship.speed }
                    | key `Keys.equal` Keys.arrowRight -> 
                      { ship | x <- ship.x + ship.speed }
                    | otherwise -> ship
      otherwise -> ship

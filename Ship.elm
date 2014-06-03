module Ship where
import Playground.Input (..)
import Keyboard.Keys as Keys

type Ship = { x : Float, y : Float,
              vx : Float, vy : Float,
              color : Color, speed : Float,
              size : Float }

enemy = { x = 0,
          y = 0,
          vx = 0,
          vy = 0,
          color = red,
          speed = 1,
          size = 10 }

initialShip : Ship
initialShip = { x = 0, 
                y = 0, 
                vx = 0, 
                vy = 0, 
                color = blue, 
                speed = 2,
                size = 20 }

render : Ship -> Form
render {x, y, color, size} = ngon 3 size |> filled color |> move (x, y)

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

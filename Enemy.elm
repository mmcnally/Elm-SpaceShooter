module Enemy where
import Ship (..)





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

-- enemyAI: Ship -> Float -> Float -> Ship
enemyAI ship = { ship | x <- if ship.vx > ship.x then ship.x + 0.5 else ship.x - 0.5,
                        y <- if ship.vy > ship.y then ship.y + 0.5 else ship.y - 0.5}


-- updateAll: Ship -> Float -> [Float] -> [Ship]
updateAll = map enemyAI



-- render = Ship.render { x, y, color, size, angle }


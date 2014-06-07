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

enemyAI: Ship -> Ship
enemyAI ship =
    let slopeNumerator = ship.vy - ship.y
        slopeDenominator = ship.vx - ship.x
        slope = slopeNumerator / slopeDenominator
        increment numer denom = if (sqrt (numer * numer) + 
                                    sqrt ( denom * denom)) > 0.5
                                then increment (numer * 0.95) (denom * 0.95)
                                else { xInc = denom, yInc = numer }
        xIncrement = (increment slopeNumerator slopeDenominator).xInc
        yIncrement = (increment slopeNumerator slopeDenominator).yInc
    in { ship | x <- ship.x + xIncrement,
                y <- ship.y + yIncrement } 

updateAll: [Ship] -> [Ship]
updateAll = map enemyAI



-- render = Ship.render { x, y, color, size, angle }


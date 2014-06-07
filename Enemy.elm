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
adjustAngle: Ship -> Float -> Float -> Float
adjustAngle ship xChange yChange= 
   let radius = sqrt (xChange ^ 2 + yChange ^ 2)
       unAdjustedAngle = asin(yChange / radius)
   in if | unAdjustedAngle > 0 && xChange < 0 -> pi - unAdjustedAngle
         | unAdjustedAngle < 0 && xChange < 0 -> pi - unAdjustedAngle
         | otherwise -> unAdjustedAngle

-- slightly moves ship if it has the same coordinates as the player's ship
correctMovement thingToModify incr playNum = if (thingToModify + incr) == playNum
                                             then incr + 0.1
                                             else incr

physics: Ship -> Ship
physics ship =
 let slopeNumerator = ship.vy - ship.y
     slopeDenominator = ship.vx - ship.x
     slope = slopeNumerator / slopeDenominator
     increment numer denom = if (sqrt (numer ^ 2 + denom ^ 2)) > ship.speed
                                then increment (numer * 0.95) (denom * 0.95)
                                else { xInc = denom, yInc = numer }
     xInc = (increment slopeNumerator slopeDenominator).xInc
     yInc = (increment slopeNumerator slopeDenominator).yInc
     xIncrement = (correctMovement ship.x xInc ship.vx)
     yIncrement = (correctMovement ship.y yInc ship.vy)
 in { ship | x <- ship.x + xIncrement,
             y <- ship.y + yIncrement,
         angle <- (adjustAngle ship xIncrement yIncrement) } 

shipAI: Ship -> Ship
shipAI = physics


updateAll: [Ship] -> [Ship]
updateAll = map shipAI



-- render = Ship.render { x, y, color, size, angle }


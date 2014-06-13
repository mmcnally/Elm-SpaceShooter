module Enemy where
import Ship (..)




 

enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 
-- type EnemyShip = { x: Float,
--                    y: Float,
--                    vx: Float,
--                    vy: Float,
--                    color: ShipColor,
--                    speed: Float,
--                    size: Float,
--                    angle: Float,
--                    accelerate: Float,
--                    playerX: Float,
--                    playerY: Float }
type EnemyShip a = Ship { playerX: Float, playerY: Float }

enemy: EnemyShip a
enemy = { x = 0,
          y = 0,
          vx = 0,
          vy = 0,
          color = enemyShipColor,
          speed = 0,
          size = 10,
          angle = 0,
          accelerate = 0,
          playerX = 0,
          playerY = 0 }

adjustAngle: EnemyShip a -> Float -> Float -> Float
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

physics: EnemyShip a -> EnemyShip a
physics ship =
 let slopeNumerator = ship.playerY - ship.y
     slopeDenominator = ship.playerX - ship.x
     slope = slopeNumerator / slopeDenominator
     increment numer denom = if (sqrt (numer ^ 2 + denom ^ 2)) > ship.speed
                                then increment (numer * 0.95) (denom * 0.95)
                                else { xInc = denom, yInc = numer }
     xInc = (increment slopeNumerator slopeDenominator).xInc
     yInc = (increment slopeNumerator slopeDenominator).yInc
     xIncrement = (correctMovement ship.x xInc ship.playerX)
     yIncrement = (correctMovement ship.y yInc ship.playerY)
 in { ship | x <- ship.x + xIncrement,
             y <- ship.y + yIncrement,
         angle <- (adjustAngle ship xIncrement yIncrement) } 

shipAI: EnemyShip a -> EnemyShip a
shipAI = physics


updateAll: [EnemyShip a] -> [EnemyShip a]
updateAll = map shipAI


render : EnemyShip a -> Form
render {x, y, color, size, angle} = 
  group [ ngon 3 size |> filled color.body,
          ngon 3 (size * 0.7) |> filled color.window |> move (size * 0.1, 0),
          ngon 3 (size * 0.2) |> filled color.body2 ] |> rotate angle |> move (x, y)

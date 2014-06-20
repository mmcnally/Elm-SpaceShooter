module Enemy where
import Ship (..)
import Bullet (..)


enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 

type EnemyShip a = Ship { a | playerX: Float, playerY: Float }

-- initial enemyship
enemy: EnemyShip {}
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
          playerY = 0,
          damage = 0,
          bullets = [] }


-- calculates angle for an enemyship so that
-- it's facing the player's ship
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
-- physics for enemy ships
-- modifies coordinates and angle
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


-- applies physics function to an enemy ship
shipAI: EnemyShip a -> EnemyShip a
shipAI = physics

-- updates list of enemy ships to orient and move them
updateAll: [EnemyShip a] -> [EnemyShip a]
updateAll = map shipAI


-- draws an enemy ship to the screen
-- ship drawn as 3 grouped triangles
render : EnemyShip a -> Form
render {x, y, color, size, angle} = 
  group [ ngon 3 size |> filled color.body,
          ngon 3 (size * 0.7) |> filled color.window |> move (size * 0.1, 0),
          ngon 3 (size * 0.2) |> filled color.body2 ] |> rotate angle |> move (x, y)

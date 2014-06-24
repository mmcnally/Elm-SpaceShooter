module Enemy where
import Ship (..)
import Bullet (..)


enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 

type EnemyShip a = Ship { a | playerX: Float, playerY: Float, intel : Float }

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
          bullets = [],
          intel = 10 }


-- calculates angle for an enemyship so that
-- it's facing the player's ship
adjustAngle: EnemyShip a -> Float -> Float -> Float
adjustAngle ship xChange yChange= 
   let radius = sqrt (xChange ^ 2 + yChange ^ 2)
       angle = abs (asin(yChange / radius))
      -- angle' = if unAdjustedAngle < 0 
      --          then (2 * pi) - unAdjustedAngle 
      --          else unAdjustedAngle
   in if | yChange < 0 && xChange < 0 -> pi + angle
         | yChange > 0 && xChange < 0 -> pi - angle
         | yChange < 0 && xChange > 0 -> (2 * pi) - angle
         | otherwise -> angle

-- slightly moves ship if it has the same coordinates as the player's ship
correctMovement thingToModify incr playNum = if (thingToModify + incr) == playNum
                                             then incr + 0.1
                                             else incr

-- makes sure that the angle is between 0 and 2 * pi
clamp angle = if | angle > (2 * pi) -> angle - (2 * pi)
                 | angle < 0 -> (2 * pi) - angle
                 | otherwise -> angle

slowAngle newAngle ship = 
  let newAngle' = newAngle
  in if (newAngle' - ship.angle) < pi && (newAngle' - ship.angle) > (-pi)
     then ship.angle + (ship.intel * (newAngle' - ship.angle) / 10000)
     else ship.angle + (ship.intel * (newAngle' - (ship.angle + (2 * pi))) / 10000)

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
         angle <- slowAngle (adjustAngle ship xIncrement yIncrement) ship } 


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

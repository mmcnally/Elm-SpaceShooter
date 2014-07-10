module Enemy where
import Ship (..)
--import Bullet (..)


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
          --bullets = [],
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

-- makes sure that angle is between 0 and 2 * pi
clampify angle = if | angle > (2 * pi) -> angle - (2 * pi)
                    | angle < 0        -> (2 * pi) - angle
                    | otherwise        -> angle

-- incorporates intelligence into angle
slowAngle newAngle ship = 
  let newAngle' = newAngle
      diff = newAngle' - ship.angle
  in if | diff < pi && diff > (-pi) -> ship.angle + (ship.intel * diff / 10000)
        | diff > 0 -> ship.angle + (ship.intel * (diff - (2 * pi)) / 10000)
        | otherwise -> ship.angle + (ship.intel * (diff + (2 * pi)) / 10000)

-- physics for enemy ships
-- modifies coordinates and angle
physics: EnemyShip a -> Float -> EnemyShip a
physics ship frameRate=
 let slopeNumerator = ship.playerY - ship.y
     slopeDenominator = ship.playerX - ship.x
     slope = slopeNumerator / slopeDenominator
     increment numer denom = if (sqrt (numer ^ 2 + denom ^ 2)) > ship.speed
                                then increment (numer * 0.95) (denom * 0.95)
                                else { xInc = denom, yInc = numer }
     xInc = (increment slopeNumerator slopeDenominator).xInc
     yInc = (increment slopeNumerator slopeDenominator).yInc
     xIncrement = frameRate * (correctMovement ship.x xInc ship.playerX)
     yIncrement = frameRate * (correctMovement ship.y yInc ship.playerY)
 in { ship | x <- ship.x + xIncrement,
             y <- ship.y + yIncrement,
         angle <- slowAngle (adjustAngle ship xIncrement yIncrement) ship } 

-- updates list of enemy ships to orient and move them
updateAll: [EnemyShip a] -> Float -> [EnemyShip a]
updateAll enemies frameRate = map (flip physics frameRate) enemies


-- draws an enemy ship to the screen
-- ship drawn as 3 grouped polygons
render : EnemyShip a -> Form
render {x, y, color, size, angle} = 
  let bodySize = size
      windowSize = size * 0.7
      body2Size = size * 0.2
  in
  group [ polygon [(-bodySize, bodySize), (-bodySize, -bodySize), (bodySize, 0)] |> filled color.body,
          polygon [(-windowSize, windowSize), (-windowSize, -windowSize), (windowSize, 0)] |> filled color.window |> move (size * 0.1, 0),
          polygon [(-body2Size, body2Size), (-body2Size, -body2Size), (body2Size, 0)] |> filled color.body2 ] |> rotate angle |> move (x, y)

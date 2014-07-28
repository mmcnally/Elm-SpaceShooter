module Enemy where
import Ship (..)
import GameAI (..)
import Asteroid
import Randoms (..)


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
          angle = 1000 * (2 * pi),
          accelerate = 0,
          playerX = 0,
          playerY = 0,
          damage = 0,
          --bullets = [],
          intel = 10,
          viewSize = 0 }


-- calculates angle for an enemyship so that
-- it's facing the player's ship
adjustAngle: EnemyShip {} -> Float -> Float -> Float
adjustAngle ship xChange yChange= 
   let radius = sqrt (xChange ^ 2 + yChange ^ 2)
       angle = abs (asin(yChange / radius))
   in if | yChange < 0 && xChange < 0 -> pi + angle
         | yChange > 0 && xChange < 0 -> pi - angle
         | yChange < 0 && xChange > 0 -> (2 * pi) - angle
         | otherwise -> angle

-- slightly moves ship if it has the same coordinates as the player's ship
correctMovement: Float -> Float -> Float -> Float
correctMovement thingToModify incr playNum = if (thingToModify + incr) == playNum
                                             then incr + 0.1
                                             else incr

-- incorporates intelligence into angle
slowAngle: Float -> EnemyShip {} -> Float
slowAngle newAngle ship = 
  let extraAngleness = ship.angle - (ship.angle - (2 * pi) * (toFloat (floor (ship.angle / (2 * pi)))))
      newAngle' = newAngle + extraAngleness
      diff = newAngle' - ship.angle
  in if | diff < pi && diff > (-pi) -> ship.angle + (ship.intel * diff / 1000)
        | diff > 0 -> ship.angle + (ship.intel * (diff - (2 * pi)) / 1000)
        | otherwise -> ship.angle + (ship.intel * (diff + (2 * pi)) / 1000)

-- physics for enemy ships
-- modifies coordinates and angle
physics: EnemyShip {} -> Float -> EnemyShip {}
physics ship frameRate=
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
     angle = slowAngle (adjustAngle ship xIncrement yIncrement) ship
     ship' = { ship |  angle <- angle,
                          vx <- cos(angle),
                          vy <- sin(angle) }
 in { ship' | x <- ship'.x + frameRate * (ship'.vx * ship'.speed),
              y <- ship'.y + frameRate * (ship'.vy * ship'.speed) }
               
-- max number of enemies allowed on screen
maxEnemies = 10

-- predicate for filter function in deleteOldEnemies
--
-- decides if an enemy is close enough to player's
-- ship to not be deleted
closeEnough: EnemyShip {} -> Ship {} -> Bool
closeEnough enemy ship = 
    if (abs (ship.x - enemy.x)) < 1200 && (abs (ship.y - enemy.y)) < 1200
    then True
    else False

-- deletes far away enemies
deleteOldEnemies: [EnemyShip {}] -> Ship {} -> [EnemyShip {}]
deleteOldEnemies enemies ship = filter (flip closeEnough ship) enemies

-- adds one enemy with random speed
addEnemy: [EnemyShip {}] -> Float -> Ship{} -> [Float] -> [EnemyShip {}]
addEnemy enemies time ship randoms = 
    let xy = randomOutOfScreen 700 1500 300 1500 time ship randoms
        x = xy.x
        y = xy.y
    in if | (length enemies) < maxEnemies ->
              { enemy | x <- x,
                        y <- y,
                    speed <- randomFloat (time * 0.34), 
                    intel <- randomNum 1 100 (time * 4.12) }::enemies
          | otherwise -> enemies

-- updates list of enemy ships to orient and move them
updateAll: [EnemyShip {}] -> Float -> Float -> Ship {} -> [Float] -> [EnemyShip {}]
updateAll enemies frameRate time ship randoms = 
    let enemies' = addEnemy enemies time ship randoms
        enemies'' = deleteOldEnemies enemies' ship
    in  map (flip physics frameRate) enemies''
        


-- draws an enemy ship to the screen
-- ship drawn as 3 grouped polygons
render : EnemyShip {} -> Form
render {x, y, color, size, angle} = 
  let bodySize = size
      windowSize = size * 0.7
      body2Size = size * 0.2
  in
  group [ polygon [(-bodySize, bodySize), 
                   (-bodySize, -bodySize),
                   (bodySize, 0)] |> filled color.body,
          polygon [(-windowSize, windowSize),
                   (-windowSize, -windowSize),
                   (windowSize, 0)] |> filled color.window 
                                    |> move (size * 0.1, 0),
          polygon [(-body2Size, body2Size),
                   (-body2Size, -body2Size),
                   (body2Size, 0)] |> filled color.body2 ] 
                                   |> rotate angle 
                                   |> move (x, y)

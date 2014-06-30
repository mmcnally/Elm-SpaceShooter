module GameAI where
import Ship (..)
import Enemy (..)
import GameState (..)
import Generator (..)
import Generator.Standard (..)


-- creates a new enemy 
updateState: GameState -> GameState
updateState state = 
  { state | enemies <- addEnemy state }

-- adds one enemy with random speed
addEnemy: GameState -> [EnemyShip {}]
addEnemy state = if (length state.enemies) < 20 
                        then { enemy | x <- (head state.enemies).x * 1.5,
                                       y <- (head state.enemies).y + 100,
                                       speed <- randomNum state.ship, 
                                       intel <- 50 }::state.enemies
                        else state.enemies

-- generates a random float between 0 and 1
randomNum: Ship {} -> Float
randomNum ship = fst <| float <| generator <| seed ship

-- creates a somewhat random seed for the generator
seed: Ship {} -> Int
seed ship = floor <| (ship.x + 0.7) * 345.0 + (ship.y + 8.4) * 837.0
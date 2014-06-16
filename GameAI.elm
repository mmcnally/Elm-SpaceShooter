module GameAI where
import Ship (..)
import Enemy (..)
import GameState (..)
import Generator (..)
import Generator.Standard (..)

updateState: GameState -> GameState
updateState state = 
  { state | enemies <- addEnemy state }


addEnemy: GameState -> [EnemyShip {}]
addEnemy state = if (length state.enemies) < 20 
                        then { enemy | x <- (head state.enemies).x * 1.5,
                                       y <- (head state.enemies).y + 100,
                                       speed <- randomNum state }::state.enemies
                        else state.enemies

randomNum: GameState -> Float
randomNum state = fst <| float <| generator <| seed state

seed: GameState -> Int
seed state = floor <| (state.ship.x + 0.7) * 345.0 + (state.ship.y + 8.4) * 837.0
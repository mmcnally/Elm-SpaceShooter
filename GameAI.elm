module GameAI where
import Ship (..)
import Enemy (..)
import GameState (..)
import Random 


-- hi = 5

updateState: GameState -> GameState
updateState state = 
  { state | enemies <- addEnemy state.enemies (length state.enemies) }


addEnemy: [EnemyShip] -> Int -> [EnemyShip]
addEnemy enemyShips l = if l < 20 
                        then { enemy | x <- (head enemyShips).x * 1.5,
                                       y <- (head enemyShips).y + 100,
                                       speed <- ((head enemyShips).speed) + 0.1 }::enemyShips
                        else enemyShips

-- randomNum: Float
-- randomNum = Random.float (every millisecond)
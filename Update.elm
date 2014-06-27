module Update where
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Asteroid
import Ship (Ship)
import Ship
import Enemy
import GameAI



-- update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let state' = GameAI.updateState state
        ship' = Ship.update input state'.ship
        asteroids' = Asteroid.updateAll state'.asteroids

        -- updates an enemy ship to give it the current
        -- coordinates of the player's ship
        updateEnemies ship = { ship | playerX <- state'.ship.x,
                                      playerY <- state'.ship.y }
        enemies' = Enemy.updateAll (map updateEnemies state'.enemies)
        time' = state'.time + 1
    in {state' | ship <- ship',
                 asteroids <- asteroids',
                 enemies <- enemies',
                 time <- time' }
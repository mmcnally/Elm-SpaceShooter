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



update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let state' = GameAI.updateState state
        ship' = Ship.update input state'.ship
        asteroids' = Asteroid.updateAll state'.asteroids
        updateEnemies ship = { ship | playerX <- state'.ship.x,
                                      playerY <- state'.ship.y }
        enemies' = Enemy.updateAll (map updateEnemies state'.enemies)
    in case input of
         otherwise -> {state' | ship <- ship',
                               asteroids <- asteroids',
                               enemies <- enemies' }



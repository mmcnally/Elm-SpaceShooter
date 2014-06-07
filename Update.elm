module Update where
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Asteroid
import Ship (Ship)
import Ship
import Enemy

update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let ship' = Ship.update input state.ship
        asteroids' = Asteroid.updateAll state.asteroids
        updateEnemies ship = { ship | vx <- state.ship.x, vy <- state.ship.y }
        enemies' = Enemy.updateAll (map updateEnemies state.enemies)
    in case input of
         otherwise -> {state | ship <- ship',
                               asteroids <- asteroids',
                               enemies <- enemies' }



module Update where
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Asteroid
import Ship (Ship)
import Ship

update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let ship' = Ship.update input state.ship
        asteroids' = Asteroid.updateAll state.asteroids
    in case input of
         otherwise -> {state | ship <- ship', asteroids <- asteroids' }


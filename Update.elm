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
    let ship' = updateShip input state.ship
        asteroids' = Asteroid.updateAll state.asteroids
    in case input of
         otherwise -> {state | ship <- ship', asteroids <- asteroids' }

updateShip : Input -> Ship -> Ship
updateShip input ship =
    case input of
      Key key -> if | key `Keys.equal` Keys.arrowLeft -> 
                      { ship | x <- ship.x - Ship.speed }
                    | key `Keys.equal` Keys.arrowRight -> 
                      { ship | x <- ship.x + Ship.speed }
                    | otherwise -> ship
      otherwise -> ship
module Render where

import GameState (..)
import Ship
import Asteroid
import Enemy


-- note: fixAngle function never seems to be called and game functions
--       normally when it is commented out
render : GameState -> [Form]
render state = 
    let shipForm = Ship.render state.ship
        asteroidForms = map Asteroid.render state.asteroids
        enemyForms = (map Enemy.render) state.enemies
        forms = enemyForms ++ asteroidForms ++ [shipForm]
        fixAngle = -state.ship.angle + pi/2
        fixPosition = (-state.ship.x, -state.ship.y)
    in  map (move  fixPosition) forms
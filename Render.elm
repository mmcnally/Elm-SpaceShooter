module Render where

import GameState (..)
import Ship
import Asteroid

render : GameState -> [Form]
render state = 
    let shipForm = Ship.render state.ship
        asteroidForms = map Asteroid.render state.asteroids
        enemyForms = (map Ship.render) state.enemies
    in enemyForms ++ asteroidForms ++ [shipForm]
module Render where

import GameState (..)
import Ship (..)
import Asteroid

render : GameState -> [Form]
render state = 
    let ship = state.ship 
        shipForm = ngon 3 20 |> filled green |> move (ship.x, ship.y)
        asteroidForms = map Asteroid.render state.asteroids
    in asteroidForms ++ [shipForm]
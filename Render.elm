module Render where

import GameState (..)
import Ship
import Asteroid
import Enemy
import Bullet


render : GameState -> [Form]
render state = 
    let shipForm = Ship.render state.ship
        asteroidForms = map Asteroid.render state.asteroids
        enemyForms = (map Enemy.render) state.enemies
        bulletForms = (map Bullet.render) (Ship.getBullets state.ship)
        forms = enemyForms ++ asteroidForms ++ shipForm ++ bulletForms
        fixPosition = (-state.ship.x, -state.ship.y)
    in  map (move  fixPosition) forms
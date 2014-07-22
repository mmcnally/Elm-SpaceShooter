module Render where
import GameState (..)
import Ship
import Asteroid
import Enemy
import Bullet
import Star
import Background


render : GameState -> [Form]
render state = 
    let shipForm = Ship.render state.ship
        asteroidForms = map Asteroid.render state.asteroids
        enemyForms = (map Enemy.render) state.enemies
        bulletForms = (map Bullet.render) state.bullets
        frameRate = [toForm <| asText <| state.frameRate]
        background = [Background.renderBackground]
        stars = (map Star.renderStars) state.stars
        forms = stars ++ enemyForms ++ asteroidForms ++ shipForm ++ bulletForms
        fixPosition = (-state.ship.x, -state.ship.y)
    in  background ++ (map (move  fixPosition) forms) ++ frameRate
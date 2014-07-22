module Render where
import GameState (..)
import Ship
import Asteroid
import Enemy
import Bullet
import Star
import Background
import Console

render : GameState -> [Form]
render state = 
    let state' = Console.renderFilter state
        shipForm = Ship.render state'.ship
        asteroidForms = map Asteroid.render state'.asteroids
        enemyForms = (map Enemy.render) state'.enemies
        bulletForms = (map Bullet.render) state'.bullets
        frameRate = [toForm <| asText <| state'.frameRate]
        background = [Background.renderBackground]
        stars = (map Star.renderStars) state'.stars
        farAsteroids = (map Asteroid.renderFarAway) state'.farAsteroids
        forms = stars ++ 
                enemyForms ++ 
                asteroidForms ++ 
                farAsteroids ++ 
                shipForm ++ 
                bulletForms
        fixPosition = (-state'.ship.x, -state'.ship.y)
    in  background ++ (map (move  fixPosition) forms) ++ frameRate
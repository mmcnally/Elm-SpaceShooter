module Render where
import GameState (..)
import Ship
import Asteroid
import Enemy
import Bullet
import Star
import Background
import Console
import Viewer

render : GameState -> [Form]
render state = 
    let state' = Console.renderFilter state
        farforms_state'' = Viewer.renderAll state'
        farForms = fst farforms_state''
        state'' = snd farforms_state''
        shipForm = Ship.render state''.ship
        asteroidForms = map Asteroid.render state''.asteroids
        enemyForms = (map Enemy.render) state''.enemies
        bulletForms = (map Bullet.render) state''.bullets
        frameRate = [toForm <| asText <| state''.frameRate]
        background = [Background.renderBackground]
        stars = (map Star.renderStars) state''.stars
        --farAsteroids = (map Asteroid.renderFarAway) state''.farAsteroids
        forms = stars ++ 
                farForms ++
                enemyForms ++ 
                asteroidForms ++ 
                --farAsteroids ++ 
                shipForm ++ 
                bulletForms
        fixPosition = (-state''.ship.x, -state''.ship.y)
    in  background ++ (map (move  fixPosition) forms) ++ frameRate
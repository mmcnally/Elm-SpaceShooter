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
import Menu
import ScoreBoard (..)

render: GameState -> [Form]
render state = if | state.gameOver == True -> [toForm <| asText "Game Over"]
                  | (fst state.isPlaying) == False -> Menu.render state
                  | otherwise -> renderAll state
                    

renderAll : GameState -> [Form]
renderAll state = 
    let consoleForms = Console.renderConsole state
        state' = Console.renderFilter state
        -- partitions objects into a list of close objects
        -- and a list of far away objects
        farforms_state = Viewer.renderAll state'
        farForms = fst farforms_state
        state'' = snd farforms_state
        shipForm = Ship.render state''.ship
        asteroidForms = map Asteroid.render state''.asteroids
        enemyForms = (map Enemy.render) state''.enemies
        bulletForms = (map Bullet.render) state''.bullets
        frameRate = [toForm <| asText <| state''.frameRate]
        postScore = renderScore state
        background = [Background.renderBackground]
        stars = (map Star.renderStars) state''.stars
        -- view rectangle
        viewThing = [move (state.ship.x, state.ship.y) <| 
                                   outlined (solid gray) <|
                                           square 400 ]
        forms = stars ++
                farForms ++
                enemyForms ++
                asteroidForms ++
                shipForm ++
                bulletForms ++
                viewThing
        fixPosition = (-state''.ship.x, -state''.ship.y)
    in  background ++ (map (move  fixPosition) forms) ++ consoleForms ++ postScore
module Viewer where
import GameState (..)
import Enemy (..)
import Ship (..)
import Asteroid (..)

type A a = { a | x: Float, y: Float }

renderAll: GameState -> ([Form], GameState)
renderAll state = 
    let enemiesPartition = partitionFarAways state.ship state.enemies
        enemies' = (fst enemiesPartition)
        enemyForms = map render (snd enemiesPartition)
        asteroidsPartition = partitionFarAways state.ship state.asteroids
        asteroids' = (fst asteroidsPartition)
        asteroidForms = map render (snd asteroidsPartition)
        state' = { state | enemies   <- enemies',
                           asteroids <- asteroids' }
    in (enemyForms ++ asteroidForms, state')


--tooFar: Ship {} -> Asteroid -> Bool
tooFar: Ship {} -> A a -> Bool
tooFar ship {x, y} = 
    if (abs (ship.x - x)) < 200 && (abs (ship.y - y)) < 200
    then True
    else False

--filterFarAways: Ship {} -> [Asteroid] -> [Asteroid]
filterFarAways ship things = filter (tooFar ship) things


partitionFarAways: Ship {} -> [A a] -> ([A a], [A a])
partitionFarAways ship things = partition (tooFar ship) things


render: A a -> Form
render {x, y} = move (x,y) <| filled orange <| circle 4
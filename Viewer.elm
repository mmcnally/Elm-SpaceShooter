module Viewer where
import GameState (..)
import Enemy (..)
import Ship (..)
import Asteroid (..)
import Bullet (..)
import QuadTree (..)

type A a = { a | x: Float, y: Float }

renderAll: GameState -> ([Form], GameState)
renderAll state = 
    let enemiesPartition = partitionFarAways state.ship (treeToList state.enemies [])
        enemies' = (fst enemiesPartition)
        enemyCoordinates = map toCoordinate enemies'
        enemyForms = map render (snd enemiesPartition)
        asteroidsPartition = partitionFarAways state.ship state.asteroids
        asteroids' = (fst asteroidsPartition)
        asteroidForms = map render (snd asteroidsPartition)
        bulletsPartition = partitionFarAways state.ship state.bullets
        bullets' = (fst bulletsPartition)
        bulletForms = map renderBullets (snd bulletsPartition)
        stars' = filter (tooFar state.ship) state.stars
        state' = { state | enemies   <- (insertList basicEmpty 
                                                    enemyCoordinates 
                                                    enemies'),
                           asteroids <- asteroids',
                           bullets   <- bullets',
                           stars     <- stars' }
    in (enemyForms ++ asteroidForms ++ bulletForms, state')


--tooFar: Ship {} -> Asteroid -> Bool
tooFar: Ship {} -> A a -> Bool
tooFar ship {x, y} = 
    if (abs (ship.x - x)) < 200 && (abs (ship.y - y)) < 200
    then True
    else False

-- partitions a list of things into a list of things that
-- are close and a list of things that are far away
partitionFarAways: Ship {} -> [A a] -> ([A a], [A a])
partitionFarAways ship things = partition (tooFar ship) things

render: A a -> Form
render {x, y} = move (x,y) <| filled orange <| circle 4


-- renders a bullet
renderBullets: A a -> Form
renderBullets {x, y} = move (x,y) <| filled orange <| circle 2
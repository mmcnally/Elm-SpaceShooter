module Asteroid where
import Bullet (..)
import Ship (..)
import Generator (..)
import Generator.Standard(..)
import GameAI (..)
import QuadTree (..)

type Asteroid = { x : Float,
                  y : Float,
                 vx : Float,
                 vy : Float,
             center : (Float, Float) }

-- creates an asteroid based on parameters
asteroid : Float -> Float -> Float -> Float -> (Float, Float) -> Asteroid
asteroid x y vx vy center = { x = x, y = y, vx = vx, vy = vy, center = center }

initialAsteroid: Asteroid
initialAsteroid = { x = 0,
                    y = 0,
                    vx = 0,
                    vy = 0,
                    center = (0, -5) }

-- applies physics to one asteroid
physics : Float -> Asteroid -> Asteroid
physics frameRate asteroid =
    let moveX = asteroid.x + frameRate * asteroid.vx
        moveY = asteroid.y + frameRate * asteroid.vy
    in
    { asteroid | x <- moveX,
                 y <- moveY,
                 center <- (0 + moveX, -5 + moveY) }

-- applies physics to each asteroid
updateAll : QuadTree Asteroid -> Float -> QuadTree Asteroid
updateAll roids frameRate = treeMap (physics frameRate) roids

-- creates a new random asteroid
createRoid: Ship {} -> Float -> [Float] -> Asteroid
createRoid ship time randoms = 
    let xy = randomOutOfScreen 700 1500 300 1500 time ship randoms
        x = xy.x
        y = xy.y
        vx = (randomNum (-1000) (1000) (time * 4.97)) / 1000
        vy = (randomNum (-1000) (1000) (time * 1.34)) / 1000
    in { initialAsteroid | x <- x,
                y <- y,
               vx <- vx,
               vy <- vy, 
           center <- (0 + x, -5 + y)}


maxRoids = 50

-- adds a new asteroid to the list
addRoid: QuadTree Asteroid -> Ship {} -> Float -> [Float] -> QuadTree Asteroid
addRoid roids ship time randoms = 
    if (floor time) `mod` 100 == 0
    then 
        let newRoid = createRoid ship time randoms
        in treeInsert roids (newRoid.x, newRoid.y) newRoid
    else roids

-- predicate for filter function in deleteOldRoids
--
-- decides if an asteroid is close enough to player's
-- ship to not be deleted
closeEnough: Ship {} -> Asteroid -> Bool
closeEnough ship roid = 
    if (abs (ship.x - roid.x)) < 2000 && (abs (ship.y - roid.y)) < 2000
    then True
    else False

-- deletes asteroids that are too far from the
-- player's ship
deleteOldRoids: QuadTree Asteroid -> Ship {} -> QuadTree Asteroid
deleteOldRoids roids ship = treeFilter (closeEnough ship) roids

-- updates all asteroids
update: QuadTree Asteroid -> Ship {} -> Float -> Float -> [Float] -> 
                                                          QuadTree Asteroid
update roids ship time frameRate randoms =
    let roids' = addRoid roids ship time randoms
        roids'' = deleteOldRoids roids' ship
        roids''' = fixTree getCoor roids''
    in  updateAll roids''' frameRate

getCoor: Asteroid -> (Float, Float)
getCoor roid = roid.center

render : Asteroid -> Form
render {x, y} = 
       polygon [(-5,0),
                (-10, -5),
                (-10, -10),
                (-5, -15),
                (5, -15),
                (10, -10),
                (10, -5), 
                (5,0)] |> filled gray |> move (x, y)
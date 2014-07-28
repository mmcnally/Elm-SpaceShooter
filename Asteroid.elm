module Asteroid where
import Bullet (..)
import Ship (..)
import Generator (..)
import Generator.Standard(..)
import GameAI (..)

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
physics : Asteroid -> Float -> Asteroid
physics asteroid frameRate =
    let moveX = asteroid.x + frameRate * asteroid.vx
        moveY = asteroid.y + frameRate * asteroid.vy
    in
    { asteroid | x <- moveX,
                 y <- moveY,
                 center <- (0 + moveX, -5 + moveY) }

-- applies physics to each asteroid
updateAll : [Asteroid] -> Float -> [Asteroid]
updateAll roids frameRate = map (flip physics frameRate) roids

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


maxRoids = 100

-- adds a new asteroid to the list
addRoid: [Asteroid] -> Ship {} -> Float -> [Float] -> [Asteroid]
addRoid roids ship time randoms = if (length roids) < maxRoids
                          then (createRoid ship time randoms)::roids
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
deleteOldRoids: [Asteroid] -> Ship {} -> [Asteroid]
deleteOldRoids roids ship = filter (closeEnough ship) roids

--tooFar: Ship {} -> Asteroid -> Bool
--tooFar ship roid = 
--    if (abs (ship.x - roid.x)) < 200 && (abs (ship.y - roid.y)) < 200
--    then True
--    else False

--filterFarAways: Ship {} -> [Asteroid] -> [Asteroid]
--filterFarAways ship roids = filter (tooFar ship) roids

-- updates all asteroids
update: [Asteroid] -> Ship {} -> Float -> Float -> [Float] -> [Asteroid]
update roids ship time frameRate randoms =
    let roids' = deleteOldRoids roids ship
        --roids' = (filterFarAways ship roids) ++ newRoids
        roids'' = addRoid roids' ship time randoms
    in  updateAll roids'' frameRate

render : Asteroid -> Form
render {x, y} = 
    let size = 10
    in polygon [(-5,0),
                (-10, -5),
                (-10, -10),
                (-5, -15),
                (5, -15),
                (10, -10),
                (10, -5), 
                (5,0)] |> filled gray |> move (x, y)

--updateFarAway: [Asteroid] -> [Asteroid] -> Ship {} -> Float -> [Asteroid]
--updateFarAway farAways roids ship frameRate = 
--    let farAways' = snd <| partition (tooFar ship) (roids ++ farAways)
--        farAways'' = deleteOldRoids farAways' ship
--    in updateAll farAways'' frameRate

-- renders far away asteroids
--renderFarAway: Asteroid -> Form
--renderFarAway {x, y} = 
--    move (x, y) <| filled gray <| circle 2
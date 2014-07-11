module Asteroid where
import Bullet (..)
import Ship (..)
import Generator (..)
import Generator.Standard(..)

type Asteroid = { x : Float,
                  y : Float,
                  vx : Float,
                  vy : Float }

-- creates an asteroid based on parameters
asteroid : Float -> Float -> Float -> Float -> Asteroid
asteroid x y vx vy = { x = x, y = y, vx = vx, vy = vy }

initialAsteroid: Asteroid
initialAsteroid = { x = 0,
                    y = 0,
                    vx = 0,
                    vy = 0 }

-- applies physics to one asteroid
physics : Asteroid -> Float -> Asteroid
physics asteroid frameRate =
    { asteroid | x <- asteroid.x + frameRate * asteroid.vx,
                 y <- asteroid.y + frameRate * asteroid.vy }

-- applies physics to each asteroid
updateAll : [Asteroid] -> Float -> [Asteroid]
updateAll roids frameRate = map (flip physics frameRate) roids

-- creates a new random asteroid
createRoid: Ship {} -> Float -> Asteroid
createRoid ship time = 
    let numX = randomNum (0) (1) (time)
        numY = randomNum (0) (1) (time * 4.987)
        xLeft = randomNum (ship.x - 900) (ship.x - 700) (time * 6.08)
        xRight = randomNum (ship.x + 700) (ship.x + 900) (time * 2.43)
        yUp = randomNum (ship.y - 900) (ship.y - 700) (time * 8.87)
        yDown = randomNum (ship.y + 700) (ship.y + 900) (time * 1.54)
        x = if numX < 0.5 
            then xLeft 
            else xRight
        y = if numY < 0.5 
            then yUp 
            else yDown
        vx = randomNum (-1) (1) (time * 4.97)
        vy = randomNum (-1) (1) (time * 1.34)
        roid = initialAsteroid
    in { roid | x <- x,
                y <- y,
                vx <- vx,
                vy <- vy}

-- will create a random number based on given seed
randomNum: Float -> Float -> Float -> Float
randomNum lower upper seed =
    fst <| floatRange (lower, upper) (generator <| floor seed)

-- adds a new asteroid to the list
addRoid: [Asteroid] -> Ship {} -> Float -> [Asteroid]
addRoid roids ship time = if (length roids) < 30
                          then (createRoid ship time)::roids
                          else roids

-- predicate for filter function in deleteOldRoids
--
-- decides if an asteroid is close enough to player's
-- ship to not be deleted
closeEnough: Asteroid -> Ship {} -> Bool
closeEnough roid ship = 
    if (abs (ship.x - roid.x)) < 1200 && (abs (ship.y - roid.y)) < 1200
    then True
    else False

-- deletes asteroids that are too far from the
-- player's ship
deleteOldRoids: [Asteroid] -> Ship {} -> [Asteroid]
deleteOldRoids roids ship = filter (flip closeEnough ship) roids

-- addRate: 


-- updates all asteroids
update: [Asteroid] -> Ship {} -> Float -> Float -> [Asteroid]
update roids ship time frameRate =
    let roids' = addRoid roids ship time
        roids'' = deleteOldRoids roids' ship
    in  updateAll roids'' frameRate

render : Asteroid -> Form
render {x, y} = 
    let size = 10
    in
    polygon [(-5,0), (-10, -5), (-10, -10), (-5, -15), (5, -15), (10, -10), (10, -5), (5,0)] |> filled black |> move (x, y)
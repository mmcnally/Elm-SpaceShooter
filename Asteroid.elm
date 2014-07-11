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
createRoid: Asteroid -> Ship {} -> Float -> Asteroid
createRoid roid ship time = 
    let x = randomNum (ship.x - 100) (ship.x + 100) (time * 2.432)
        y = randomNum (ship.y - 100) (ship.y + 100) (time * 432.11)
        vx = randomNum (-1) (1) (time * 121.321)
        vy = randomNum (-1) (1) (time * 234.1)
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
addRoid roids ship time = if (length roids) < 10
                          then (createRoid (head roids) ship time)::roids
                          else roids

closeEnough: Asteroid -> Ship {} -> Bool
closeEnough roid ship = 
    if (abs (ship.x - roid.x)) < 200 && (abs (ship.y - roid.y)) < 200
    then True
    else False

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
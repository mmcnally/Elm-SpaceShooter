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
physics : Asteroid -> Asteroid
physics asteroid =
    { asteroid | x <- asteroid.x + asteroid.vx,
                 y <- asteroid.y + asteroid.vy }


-- applies physics to each asteroid
updateAll : [Asteroid] -> [Asteroid]
updateAll = map physics

-- creates a new random asteroid
createRoid: Asteroid -> Ship {} -> Float -> Asteroid
createRoid roid ship time = 
    let x = randomNum (ship.x - 100) (ship.x + 100) (time * 2.432)
        y = randomNum (ship.y - 100) (ship.y + 100) (time * 432.11)
        vx = randomNum (-3) (3) (time * 121.321)
        vy = randomNum (-3) (3) (time * 234.1)
    in { roid | x <- x,
                y <- y,
                vx <- vx,
                vy <- vy}

-- will create a random number based on given seed
-- NOT IMPLEMENTED PROPERLY YET
randomNum: Float -> Float -> Float -> Float
randomNum lower upper seed =
    fst <| floatRange (lower, upper) (generator <| floor seed)

-- adds a new asteroid to the list
addRoid: [Asteroid] -> Ship {} -> Float -> [Asteroid]
addRoid roids ship time = (createRoid (head roids) ship time)::roids

-- updates all asteroids
update: [Asteroid] -> Ship {} -> Float -> [Asteroid]
update roids ship time =
    let roids' = if (length roids) < 10
                 then addRoid roids ship time
                 else roids
    in updateAll roids'

render : Asteroid -> Form
render {x, y} = circle 10 |> filled black |> move (x, y)
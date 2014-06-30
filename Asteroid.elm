module Asteroid where
import Bullet (..)

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
createRoid: Asteroid -> Asteroid
createRoid roid = 
    let x = randomNum 3
        y = randomNum 2
        vx = randomNum 1
        vy = randomNum 1
    in { roid | x <- roid.x + 10,
                y <- roid.y + 10,
                vx <- roid.vx + 1,
                vy <- roid.vy + 1 }

-- will create a random number based on given seed
-- NOT IMPLEMENTED PROPERLY YET
randomNum seed = 5

-- adds a new asteroid to the list
addRoid: [Asteroid] -> [Asteroid]
addRoid roids = (createRoid (head roids))::roids

-- updates all asteroids
update: [Asteroid] -> [Asteroid]
update roids =
    let roids' = if (length roids) < 10
                 then addRoid roids
                 else roids
    in updateAll roids'

render : Asteroid -> Form
render {x, y} = circle 10 |> filled black |> move (x, y)
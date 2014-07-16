module Background where
import Ship (..)
import GameAI (..)
import Generator (..)
import Generator.Standard (..)

type Star = { x : Float,
              y : Float,
              color: Color,
              size: Float }

initialStar: Star
initialStar = { x = 0,
                y = 0,
                color = yellow,
                size = 8 }

initialStars: [Star]
initialStars  = 
    initialHelper 30 [] (fst <| listOf (floatRange (0, 1000)) 31 (generator 5)) 1

initialHelper: Float -> [Star] -> [Float] -> Float -> [Star]
initialHelper num stars randoms time = 
    if num > 0
    then (initialHelper (num - 1) 
                        ((createStarOnScreen time randoms)::stars) 
                        (tail randoms) 
                        (time + 1))
    else stars

createStarOnScreen: Float -> [Float] -> Star
createStarOnScreen time randoms = 
    let xy = randomOutOfScreen 0 700 0 300 time initialShip randoms
    in { initialStar | x <- xy.x,
                       y <- xy.y }

-- makes some stars
addStars: [Star] -> Ship {} -> Float -> [Float] -> [Star]
addStars stars ship time randoms = 
    if (length stars) < 200 || (floor time) `mod` 15 == 0
    then (createStar ship time randoms)::stars
    else stars


-- creates a star   
createStar: Ship {} -> Float -> [Float] -> Star
createStar ship time randoms = 
    let xy = randomOutOfScreen 700 1500 300 1500 time ship randoms
        x = xy.x
        y = xy.y
    in { initialStar | x <- x,
                       y <- y }


maxDistance = 2000

--decides if star is too far away
closeEnough: Star -> Ship {} -> Bool
closeEnough star ship =
    if (abs (ship.x - star.x)) < maxDistance && 
       (abs (ship.y - star.y)) < maxDistance
    then True
    else False


-- deletes stars that are too far away
deleteStars: [Star] -> Ship {} -> [Star]
deleteStars stars ship = filter (flip closeEnough ship) stars




-- checks to see if there should be more
-- stars and creates a star if needed
update: [Star] -> Ship {} -> Float -> [Float] -> [Star]
update stars ship time randoms = 
    let stars' = addStars stars ship time randoms
        stars'' = deleteStars stars' ship
    in stars''

-- renders single color background
renderBackground: Form
renderBackground = filled black (square 1500)

--renders stars
renderStars: Star -> Form
renderStars {x, y, size, color} = 
    move (x, y) <| filled color (ngon 3 size)
    --move (0, 500) <| filled color (ngon 3 size)
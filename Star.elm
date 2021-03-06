module Star where
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

-- set of stars that appear on the screen at the start of the game
initialStars: [Star]
initialStars  = 
    let randoms = fst <| listOf (floatRange (0, 1000)) 21 (generator 5)
    in initialHelper 20 [] randoms 1

-- helper function for initialStars
initialHelper: Float -> [Star] -> [Float] -> Float -> [Star]
initialHelper num stars randoms time = 
    if num > 0
    then (initialHelper (num - 1) 
                        ((createStarOnScreen time randoms)::stars) 
                        (tail randoms) 
                        (time + 1))
    else stars

-- creates a star on screen
createStarOnScreen: Float -> [Float] -> Star
createStarOnScreen time randoms = 
    let xy = randomOutOfScreen 0 700 0 300 time initialShip randoms
    in { initialStar | x <- xy.x,
                       y <- xy.y }

maxStars = 100

-- adds a random star if there aren't enough
addStars: [Star] -> Ship {} -> Float -> [Float] -> [Star]
addStars stars ship time randoms = 
    if (length stars) < maxStars
    then (createStar ship time randoms)::stars
    else stars


-- creates a random star off screen
createStar: Ship {} -> Float -> [Float] -> Star
createStar ship time randoms = 
    let xy = randomOutOfScreen 700 1500 300 1500 time ship randoms
        x = xy.x
        y = xy.y
    in { initialStar | x <- x,
                       y <- y }

-- maximum distance that stars are allowed to be
-- from the player's ship before they're deleted
maxDistance = 2000

--decides if star is too far away from the player's ship
closeEnough: Ship {} -> Star -> Bool
closeEnough ship star =
    if (abs (ship.x - star.x)) < maxDistance && 
       (abs (ship.y - star.y)) < maxDistance
    then True
    else False


-- deletes stars that are too far away from the player's ship
deleteStars: [Star] -> Ship {} -> [Star]
deleteStars stars ship = filter (closeEnough ship) stars




-- checks to see if there should be more
-- stars and creates a star if needed
update: [Star] -> Ship {} -> Float -> [Float] -> [Star]
update stars ship time randoms = 
    let stars' = addStars stars ship time randoms
        stars'' = deleteStars stars' ship
    in stars''


--renders stars
renderStars: Star -> Form
renderStars {x, y, size, color} = 
    move (x, y) <| filled color (ngon 3 size)
    --move (0, 500) <| filled color (ngon 3 size)
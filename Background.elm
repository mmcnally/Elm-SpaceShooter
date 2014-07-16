module Background where
import Ship (..)
import GameAI (..)

type Star = { x : Float,
              y : Float,
              color: Color,
              size: Float }

initialStar: Star
initialStar = { x = 0,
                y = 0,
                color = yellow,
                size = 10 }

-- makes some stars
addStars: [Star] -> Ship {} -> Float -> [Float] -> [Star]
addStars stars ship time randoms = 
    if (length stars) < 15 || (floor time) `mod` 5 == 0
    then (createStar ship time randoms)::stars
    else stars


-- creates a star   
createStar: Ship {} -> Float -> [Float] -> Star
createStar ship time randoms = 
    let xy = randomOutOfScreen time ship randoms
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
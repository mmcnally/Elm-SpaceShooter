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
addStars: [Star] -> Ship {} -> Float -> [Star]
addStars stars ship time = 
    if (length stars) < 150
    then (createStar ship time)::stars
    else stars


-- creates a star   
createStar: Ship {} -> Float -> Star
createStar ship time = 
    let numX = randomFloat time
        numY = randomFloat (time * 3.54)
        xL = randomNum (ship.x - 1500) (ship.x - 700) (time * 1.54)
        xR = randomNum (ship.x + 700) (ship.x + 1500) (time * 2.73)
        yU = randomNum (ship.y - 1500) (ship.y - 700)(time * 9.05)
        yD = randomNum (ship.y + 700) (ship.y + 1500) (time * 4.63)
        x = if numX < 0.5 
            then xL 
            else xR
        y = if numY < 0.5 
            then yU
            else yD
    in { initialStar | x <- x,
                       y <- y }



--decides if star is too far away
closeEnough: Star -> Ship {} -> Bool
closeEnough star ship =
    if (abs (ship.x - star.x)) < 1200 && (abs (ship.y - star.y)) < 1500
    then True
    else False


-- deletes stars that are too far away
deleteStars: [Star] -> Ship {} -> [Star]
deleteStars stars ship = filter (flip closeEnough ship) stars




-- checks to see if there should be more
-- stars and creates a star if needed
update: [Star] -> Ship {} -> Float -> [Star]
update stars ship time = 
    let stars' = addStars stars ship time
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
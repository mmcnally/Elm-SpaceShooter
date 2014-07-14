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
    if (length stars) < 50
    then (createStar ship time)::stars
    else stars
    
createStar: Ship {} -> Float -> Star
createStar ship time = 
    let numX = randomFloat time
        numY = randomFloat (time * 3.54)
        xL = xLeft ship.x (time * 1.54)
        xR = xRight ship.x (time * 2.73)
        yU = yUp ship.y (time * 9.05)
        yD = yDown ship.y (time * 4.63)
        x = if numX < 0.5 
            then xL 
            else xR
        y = if numY < 0.5 
            then yU
            else yD
    in { initialStar | x <- x,
                       y <- y }


update: [Star] -> Ship {} -> Float -> [Star]
update stars ship time = 
    let stars' = addStars stars ship time
    in stars'


-- renders single color background
renderBackground: Form
renderBackground = filled gray (square 1500)

--renders stars
renderStars: Star -> Form
renderStars {x, y, size, color} = 
    move (x, y) <| filled color (ngon 3 size)
    --move (0, 500) <| filled color (ngon 3 size)
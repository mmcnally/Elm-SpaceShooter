module GameAI where
import Generator (..)
import Generator.Standard (..)



-- will create a random number between
-- given range with given seed
randomNum: Float -> Float -> Float -> Float
randomNum lower upper seed =
    fst <| floatRange (lower, upper) (generator <| floor seed)


-- random number between 0 and 1 based
-- on given seed
randomFloat seed = randomNum (0) (1) (seed)



-- generates starting x-coordinate
-- off left side of the screen
xLeft shipX seed = randomNum (shipX - 900) (shipX - 700) seed


-- generates starting x-coordinate
-- off right side of screen
xRight shipX seed = randomNum (shipX + 700) (shipX + 900) seed

-- generates starting y-coordinate above screen
yUp shipY seed = randomNum (shipY - 900) (shipY - 700) seed

-- generates starting y-coordinate below screen
yDown shipY seed = randomNum (shipY + 700) (shipY + 900) seed
module GameAI where
import Generator (..)
import Generator.Standard (..)
import Ship (..)


-- will create a random number between
-- given range with given seed
randomNum: Float -> Float -> Float -> Float
randomNum lower upper seed =
    fst <| floatRange (lower, upper) (generator <| floor seed)

-- randomWithGenerator : Float -> Float -> Float -> (Float, Generator)
randomWithGenerator lower upper seed =
    floatRange (lower, upper) (generator <| floor seed)


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



--
-- New version to replace above functions
--


-- rand lower upper gen = fst <| floatRange lower upper gen


randomOutOfScreen: Float -> Ship {} -> (Float, Float)
randomOutOfScreen seed ship = 
    let initial = randomNum  0 1 seed
        leftSeed = randomNum 0 1 initial
        rightSeed = randomNum 0 1 leftSeed
        aboveSeed = randomNum 0 1 rightSeed
        belowSeed = randomNum 0 1 aboveSeed
    in if | initial < 0.25 -> leftOfScreen ship leftSeed
          | initial < 0.5  -> rightOfScreen ship rightSeed
          | initial < 0.75 -> aboveScreen ship aboveSeed
          | otherwise      -> belowScreen ship belowSeed

leftOfScreen: Ship {} -> Float -> (Float, Float)
leftOfScreen ship seed = 
    let x = randomNum (ship.x - 1500) (ship.x - 700) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) x
    in (x, y)

rightOfScreen ship seed = 
    let x = randomNum (ship.x + 700) (ship.x + 1500) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) x
    in (x, y)

aboveScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y + 700) (ship.y + 1500) x
    in (x, y)

belowScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y + 700) (ship.y + 1500) x
    in (x, y)
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


-- returns random pair (x, y) 
randomOutOfScreen: Float -> Ship {} -> [Float] -> { x: Float, y: Float }
randomOutOfScreen seed ship randoms = 
    let one = head randoms
        two = head (tail randoms)
        initial = randomNum 0 1000 one
        newSeed = randomNum 0 1000 two
    in if | initial < 250   -> leftOfScreen ship newSeed
          | initial < 500   -> rightOfScreen ship newSeed
          | initial < 750   -> aboveScreen ship newSeed
          | otherwise       -> belowScreen ship newSeed

leftOfScreen: Ship {} -> Float -> { x: Float, y: Float }
leftOfScreen ship seed = 
    let x = randomNum (ship.x - 1500) (ship.x - 700) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) (seed * 32.44)
    in { x = x, y = y }

rightOfScreen: Ship {} -> Float -> { x: Float, y: Float }
rightOfScreen ship seed = 
    let x = randomNum (ship.x + 700) (ship.x + 1500) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) (seed * 85.24)
    in { x = x, y = y }

aboveScreen: Ship {} -> Float -> { x: Float, y: Float }
aboveScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y + 300) (ship.y + 1500) (seed * 4.64)
    in { x = x, y = y }

belowScreen: Ship {} -> Float -> { x: Float, y: Float }
belowScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y - 1500) (ship.y - 300) (seed * 9.20)
    in { x = x, y = y }
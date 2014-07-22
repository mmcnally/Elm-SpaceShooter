module GameAI where
import Generator (..)
import Generator.Standard (..)
import Ship (..)


-- creates a random number between
-- given range with given seed
randomNum: Float -> Float -> Float -> Float
randomNum lower upper seed =
    fst <| floatRange (lower, upper) (generator <| floor seed)


-- creates a random number between 0 and 1
randomFloat: Float -> Float
randomFloat seed = (randomNum 0 1000 seed) / 1000



-- returns random pair (x, y) 
randomOutOfScreen: Float -> Float -> Float -> Float -> Float -> Ship {} -> [Float] -> { x: Float, y: Float }
randomOutOfScreen xMin xMax yMin yMax seed ship randoms = 
    let one = head randoms
        two = head (tail randoms)
        initial = randomNum 0 1000 one
        newSeed = randomNum 0 1000 two
    in if | initial < 250   -> leftOfScreen xMin xMax yMin yMax ship newSeed
          | initial < 500   -> rightOfScreen xMin xMax yMin yMax ship newSeed
          | initial < 750   -> aboveScreen xMin xMax yMin yMax ship newSeed
          | otherwise       -> belowScreen xMin xMax yMin yMax ship newSeed

-- helper function for randomOutOfScreen
-- creates x, y coordinates off left side of screen
leftOfScreen: Float -> Float -> Float -> Float -> Ship {} -> Float -> { x: Float, y: Float }
leftOfScreen xMin xMax yMin yMax ship seed = 
    let x = randomNum (ship.x - xMax) (ship.x - xMin) seed
        y = randomNum (ship.y - yMax) (ship.y + yMax) (seed * 32.44)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates off right side of screen
rightOfScreen: Float -> Float -> Float -> Float -> Ship {} -> Float -> { x: Float, y: Float }
rightOfScreen xMin xMax yMin yMax ship seed = 
    let x = randomNum (ship.x + xMin) (ship.x + xMax) seed
        y = randomNum (ship.y - yMax) (ship.y + yMax) (seed * 85.24)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates above the screen
aboveScreen: Float -> Float -> Float -> Float -> Ship {} -> Float -> { x: Float, y: Float }
aboveScreen xMin xMax yMin yMax ship seed =
    let x = randomNum (ship.x - xMax) (ship.x + xMax) seed
        y = randomNum (ship.y + yMin) (ship.y + yMax) (seed * 4.64)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates below the screen
belowScreen: Float -> Float -> Float -> Float -> Ship {} -> Float -> { x: Float, y: Float }
belowScreen xMin xMax yMin yMax ship seed =
    let x = randomNum (ship.x - xMax) (ship.x + xMax) seed
        y = randomNum (ship.y - yMax) (ship.y - yMin) (seed * 9.20)
    in { x = x, y = y }
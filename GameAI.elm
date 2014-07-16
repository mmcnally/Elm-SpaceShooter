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

-- helper function for randomOutOfScreen
-- creates x, y coordinates off left side of screen
leftOfScreen: Ship {} -> Float -> { x: Float, y: Float }
leftOfScreen ship seed = 
    let x = randomNum (ship.x - 1500) (ship.x - 700) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) (seed * 32.44)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates off right side of screen
rightOfScreen: Ship {} -> Float -> { x: Float, y: Float }
rightOfScreen ship seed = 
    let x = randomNum (ship.x + 700) (ship.x + 1500) seed
        y = randomNum (ship.y - 1500) (ship.y + 1500) (seed * 85.24)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates above the screen
aboveScreen: Ship {} -> Float -> { x: Float, y: Float }
aboveScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y + 300) (ship.y + 1500) (seed * 4.64)
    in { x = x, y = y }

-- helper function for randomOutOfScreen
-- creates x, y coordinates below the screen
belowScreen: Ship {} -> Float -> { x: Float, y: Float }
belowScreen ship seed =
    let x = randomNum (ship.x - 1500) (ship.x + 1500) seed
        y = randomNum (ship.y - 1500) (ship.y - 300) (seed * 9.20)
    in { x = x, y = y }
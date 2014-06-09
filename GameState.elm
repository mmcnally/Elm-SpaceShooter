module GameState where
import Ship (..)
import Asteroid (..)

type GameState = { ship : Ship,
                   asteroids : [Asteroid],
                   enemies : [Ship] }

initialState = { ship = initialShip,
                 asteroids = [asteroid 200 200 -0.5 -1,
                              asteroid -200 200 0.1 -0.25],
                 enemies = [ {enemy | x <- 50, y <- 50, speed <- 1.0},
                             {enemy | x <- -100, y <- 200, speed <- 0.4 },
                             {enemy | x <- 100, y <- -150, speed <- 0.1 }] }
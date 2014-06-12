module GameState where
import Ship (..)
import Asteroid (..)
import Enemy (..)

type GameState = { ship : Ship,
                   asteroids : [Asteroid],
                   enemies : [EnemyShip] }

initialState = { ship = initialShip,
                 asteroids = [asteroid 200 200 -0.5 -1,
                              asteroid -200 200 0.1 -0.25],
                 enemies = [ {enemy | x <- 50, y <- 50, speed <- 1.0, playerX <- 50},
                             {enemy | x <- -100, y <- 200, speed <- 0.4 },
                             {enemy | x <- 100, y <- -150, speed <- 0.1 }] }
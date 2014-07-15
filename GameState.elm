module GameState where
import Ship (..)
import Asteroid (..)
import Enemy (..)
import Bullet (..)
import Background (..)

type GameState = { ship : Ship {},
                   asteroids : [Asteroid],
                   enemies : [EnemyShip {}],
                   bullets : [Bullet],
                   time: Float,
                   frameRate: Float,
                   stars: [Star] }

initialState: GameState
initialState = { ship = initialShip,
                 asteroids = [],
                 enemies = [ {enemy | x <- 50, y <- 50, speed <- 1.0, playerX <- 50},
                             {enemy | x <- -100, y <- 200, speed <- 0.4 },
                             {enemy | x <- 100, y <- -150, speed <- 0.1 }],
                 bullets = [bullet 200 200 0 0 0 0 0 0 (0, 0)],
                 time = 0,
                 frameRate = 0.0,
                 stars = [initialStar] }
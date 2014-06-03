module GameState where
import Ship (..)
import Asteroid (..)

type GameState = { ship : Ship,
                   asteroids : [Asteroid]}

initialState = { ship = initialShip,
                 asteroids = [asteroid 200 200 -0.5 -1,
                              asteroid -200 200 0.1 -0.25] }
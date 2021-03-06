module GameState where
import Ship (..)
import Asteroid (..)
import Enemy (..)
import Bullet (..)
import Star (..)
import Generator (..)
import Generator.Standard (..)
import Randoms (..)
import Radar (..)
import QuadTree (..)

type GameState = { ship : Ship {},
                   asteroids : QuadTree Asteroid,
                   enemies : QuadTree (EnemyShip {}),
                   bullets : [Bullet],
                   time: Float,
                   frameRate: Float,
                   stars: [Star],
                   randoms: ([Float], Generator Standard),
                   isPlaying: (Bool, Int),
                   gameOver: Bool,
                   radarForms: [Coordinate {}], 
                   score: Int,
                   explosions: [(Float, Float)] }

initialState: GameState
initialState = { ship = initialShip,
                 asteroids = basicEmpty,
                 enemies = basicEmpty,
                 bullets = [],
                 time = 0,
                 frameRate = 0.0,
                 stars = initialStars,
                 randoms = initialRandoms,
                 isPlaying = (False, -1),
                 gameOver = False,
                 radarForms = [], 
                 score = 0,
                 explosions = [] }

module Update where
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Asteroid (Asteroid)
import Asteroid
import Ship (Ship)
import Ship
import Enemy
import GameAI
import Bullet (Bullet)
import Bullet
import Background
import Randoms
import Star



update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let ship' = Ship.update input state.ship state.frameRate

        asteroids' = Asteroid.update state.asteroids 
                                     state.ship 
                                     state.time 
                                     state.frameRate 
                                     (fst state.randoms) 
                                     state.farAsteroids

        -- updates an enemy ship to give it the current
        -- coordinates of the player's ship
        updateEnemies ship = { ship | playerX <- state.ship.x,
                                      playerY <- state.ship.y }

        frameRate' = case input of
                       Passive t -> 1 / (1000 / (60 * t))
                       otherwise -> state.frameRate

        stars' = Star.update state.stars 
                             state.ship 
                             state.time 
                             (fst state.randoms)

        enemies' = Enemy.updateAll (map updateEnemies state.enemies) 
                                   state.frameRate 
                                   state.time 
                                   state.ship 
                                   (fst state.randoms)

        bullets' = Bullet.update input 
                                 state.bullets
                                 state.ship
                                 state.frameRate

        time' = state.time + 1 * frameRate'

        randoms' = Randoms.update state.randoms

        --farAsteroids' = Asteroid.updateFarAway state.farAsteroids 
        --                                       state.asteroids 
        --                                       state.ship
        --                                       state.frameRate
    in {state | ship <- ship',
                asteroids <- asteroids',
                enemies <- enemies',
                time <- time',
                bullets <- bullets',
                frameRate <- frameRate',
                stars <- stars',
                randoms <- randoms' }

    --collisionDetection state

-- map: (a -> b) -> [Bullet] -> [function [Asteroid] -> GameState]
-- a: Bullet
-- (collisionDetection bullet): function' [Asteroids] -> Gamestate
-- map collisitonDetection

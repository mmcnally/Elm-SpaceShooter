module Update where
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Asteroid
import Ship
import Enemy
import GameAI
import Bullet
import Background
import Randoms
import Star
import Menu
import Radar
import Collision (..)
import QuadTree (..)



update realWorld input state = 
    if | state.gameOver == True -> state
       | (fst state.isPlaying) == False -> Menu.update realWorld input state
       | otherwise -> updateAll realWorld input state

updateAll : RealWorld -> Input -> GameState -> GameState
updateAll realWorld input state =
    let state' = Menu.update realWorld input state
        ship' = Ship.update input state'.ship state'.frameRate
        asteroids' = Asteroid.update state'.asteroids 
                                     state'.ship 
                                     state'.time 
                                     state'.frameRate 
                                     (fst state'.randoms)
       
        frameRate' = case input of
                       Passive t -> 1 / (1000 / (60 * t))
                       otherwise -> state'.frameRate
        stars' = Star.update state'.stars 
                             state'.ship 
                             state'.time 
                             (fst state'.randoms)
        enemies' = Enemy.updateAll state'.enemies
                                   state'.frameRate 
                                   state'.time 
                                   state'.ship 
                                   (fst state'.randoms)
        bullets' = Bullet.update input 
                                 state'.bullets
                                 state'.ship
                                 state'.frameRate
        time' = state'.time + 1 * frameRate'
        randoms' = Randoms.update state'.randoms
        radarForms' = Radar.update state'.asteroids
                                   state'.enemies
                                   state'.bullets
                                   state'.ship
        state'' = { state' | ship <- ship',
                    asteroids  <- asteroids',
                    enemies    <- enemies',
                    time       <- time',
                    bullets    <- bullets',
                    frameRate  <- frameRate',
                    stars      <- stars',
                    randoms    <- randoms',
                    radarForms <- radarForms'}
    --in state''   
    in collisionDetection state''
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
import Enemy (EnemyShip)
import GameAI
import Bullet (Bullet)
import Bullet
import Background
import Randoms
import Star
import Menu
import Radar

type Location a = { a | center : (Float, Float) }
type Location' a = {a | x: Float,
                        y: Float }

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

        -- updates an enemy ship to give it the current
        -- coordinates of the player's ship
        updateEnemies ship = { ship | playerX <- state'.ship.x,
                                      playerY <- state'.ship.y }

        frameRate' = case input of
                       Passive t -> 1 / (1000 / (60 * t))
                       otherwise -> state'.frameRate

        stars' = Star.update state'.stars 
                             state'.ship 
                             state'.time 
                             (fst state'.randoms)

        enemies' = Enemy.updateAll (map updateEnemies state'.enemies) 
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
          in
          collisionDetection state''

-- map: (a -> b) -> [Bullet] -> [function [Asteroid] -> GameState]
-- a: Bullet
-- (collisionDetection bullet): function' [Asteroids] -> Gamestate

collisionDetection: GameState -> GameState
collisionDetection state = 
    let state' = collisionDetection' state 
                                     state.bullets 
                                     [] 
                                     state.asteroids 
                                     state.asteroids 
                                     []
    in
    collisionDetection'' state' 
                         state'.bullets 
                         [] 
                         state'.enemies 
                         state'.enemies 
                         [] 

collisionDetection': GameState -> [Bullet] -> [Asteroid] -> [Asteroid] -> 
                                [Asteroid] ->   [Bullet] -> GameState
collisionDetection'  modifiedState modifiableBullets prevAsteroids 
                     uncheckedAsteroids currentAsteroids finalBullets = 
    let theBullets = modifiableBullets
        theAsteroids = uncheckedAsteroids
    in case theBullets of
        -- All Bullets checked
        [] -> { modifiedState | bullets <- finalBullets,
                                asteroids <- currentAsteroids }

        -- Particular Bullet is not colliding with Asteroid
        otherwise -> 
            case theAsteroids of
              [] -> let newFinalBullets = (head theBullets) :: finalBullets
                    in
                      collisionDetection' modifiedState 
                                          (tail theBullets) 
                                          [] 
                                          currentAsteroids 
                                          currentAsteroids 
                                          newFinalBullets 
                                          
              -- Bullet evaluation
              otherwise ->
              -- Bullet not overlapping particular asteroid
                  if not (overlap (head theBullets) (head theAsteroids))
                  then
                     collisionDetection' modifiedState 
                                         theBullets 
                                         ((head theAsteroids) :: prevAsteroids) 
                                         (tail theAsteroids) 
                                         currentAsteroids 
                                         finalBullets 
                  -- Bullet is overlapping particular asteroid
                  else
                      let newCurrentAsteroids = (prevAsteroids ++ (tail theAsteroids))
                      in
                      collisionDetection' modifiedState 
                                          (tail modifiableBullets) 
                                          [] 
                                          newCurrentAsteroids 
                                          newCurrentAsteroids 
                                          finalBullets 

collisionDetection'': GameState -> [Bullet] -> [EnemyShip {}] -> [EnemyShip {}] -> [EnemyShip {}] -> [Bullet] -> GameState
collisionDetection''  modifiedState 
                      modifiableBullets 
                      prevEnemies 
                      uncheckedEnemies 
                      currentEnemies 
                      finalBullets = 

    let theBullets = modifiableBullets
        theEnemies = uncheckedEnemies
    in
    case theBullets of
        -- All Bullets checked
        [] -> { modifiedState | bullets <- finalBullets,
                                enemies <- currentEnemies }

        -- Particular Bullet is not colliding with Asteroid
        otherwise -> 
            case theEnemies of
              [] -> let newFinalBullets = (head theBullets) :: finalBullets
                    in
                      collisionDetection'' modifiedState 
                                           (tail theBullets) 
                                           [] 
                                           currentEnemies 
                                           currentEnemies 
                                           newFinalBullets 
                                          
              -- Bullet evaluation
              otherwise ->
              -- Bullet not overlapping particular asteroid
                  if not (overlap' (head theBullets) (head theEnemies))
                  then
                     collisionDetection'' modifiedState 
                                          theBullets 
                                          ((head theEnemies) :: prevEnemies) 
                                          (tail theEnemies) 
                                          currentEnemies 
                                          finalBullets 
                  -- Bullet is overlapping particular asteroid
                  else
                      let newCurrentEnemies = (prevEnemies ++ (tail theEnemies))
                      in
                      collisionDetection'' modifiedState 
                                           (tail modifiableBullets) 
                                           [] 
                                           newCurrentEnemies 
                                           newCurrentEnemies 
                                           finalBullets 

overlap: Location a -> Location b -> Bool
overlap = 
    inDistance 12.5 

overlap': Location a -> Location' b -> Bool
overlap' = 
    inDistance' 12.5    

distance: (Float, Float) -> (Float, Float) -> Float
distance shapeOne shapeTwo = 
    let divisor = ((fst shapeTwo) - (fst shapeOne))^2 + 
                  ((snd shapeTwo) - (snd shapeOne))^2 
    in sqrt divisor

inDistance: Float -> Location a -> Location b -> Bool
inDistance d shape1 shape2 =
    (distance (shape1.center) (shape2.center) ) < d

inDistance': Float -> Location a -> Location' b -> Bool
inDistance' d shape1 shape2 =
    (distance (shape1.center) (shape2.x, shape2.y) ) < d
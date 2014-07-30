module Collision where
import GameState (..)
import Bullet (Bullet)
import Asteroid (Asteroid)
import Enemy (EnemyShip)

type Location a = { a | center : (Float, Float) }
type Location' a = {a | x: Float,
                        y: Float }

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
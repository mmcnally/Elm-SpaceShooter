module Collision where
import GameState (..)
import Bullet (Bullet)
import Asteroid (..)
import Enemy (..)
import QuadTree (..)
 
{-
type Location a = { a | center : (Float, Float) }
type Location' a = {a | x: Float,
                        y: Float }

collisionDetection: GameState -> GameState
collisionDetection state = 
    let state' = collisionDetection' state 
                                     state.bullets 
                                     [] 
                                     (treeToList state.asteroids []) 
                                     (treeToList state.asteroids [])
                                     []
    in
    collisionDetection'' state' 
                         state'.bullets 
                         [] 
                         (treeToList state'.enemies [])
                         (treeToList state'.enemies [])
                         [] 

collisionDetection': GameState -> [Bullet] -> [Asteroid] -> [Asteroid] -> 
                                [Asteroid] ->  [Bullet] -> GameState
collisionDetection' modifiedState modifiableBullets prevAsteroids 
                    uncheckedAsteroids currentAsteroids finalBullets = 
    let theBullets = modifiableBullets
        theAsteroids = uncheckedAsteroids
        coordinates = map toCoordinate currentAsteroids
    in case theBullets of
        -- All Bullets checked
        [] -> { modifiedState | bullets <- finalBullets,
                                asteroids <- (insertList basicEmpty 
                                                         coordinates 
                                                         currentAsteroids) }

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
        coordinates = map toCoordinate currentEnemies
    in
    case theBullets of
        -- All Bullets checked
        [] -> { modifiedState | bullets <- finalBullets,
                                enemies <- (insertList basicEmpty 
                                                       coordinates 
                                                       currentEnemies) }

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



-}

--
--
-- Collision Detection 2.0
--
--

colDet: GameState -> GameState
colDet state = 
    let state' = checkBulletsAndAsteroids state                                      
        --state'' = checkBulletsAndEnemies state'
    in state'

checkBulletsAndAsteroids: GameState -> GameState
checkBulletsAndAsteroids state = 
    let remainingBulletsAndRoids = checkIfAsteroidsNotClose state.asteroids 
                                                            state.bullets
                                                            state.asteroids
                                                            []
        roids' = fst remainingBulletsAndRoids
        bullets' = snd remainingBulletsAndRoids
    in { state | asteroids <- roids',
                 bullets <- bullets' }

-- checks list of bullets with list of asteroids to see if
-- any bullets are near any asteroids
-- returns list of asteroids and bullets after colliding
-- objects have been omitted
checkIfAsteroidsNotClose: QuadTree Asteroid -> [Bullet] -> QuadTree Asteroid -> 
                          [Bullet] -> (QuadTree Asteroid, [Bullet])
checkIfAsteroidsNotClose roids bullets remainingRoids remainingBullets = 
  case bullets of
    [] -> (remainingRoids, remainingBullets)
    otherwise -> 
        let bullet = head bullets
            possibleRoids = getLeaf roids (bullet.x, bullet.y)
            checkBullet = checkRoidsLeft bullet possibleRoids [] False
            roidsLeft = if (snd <| checkBullet)
                        then editLeaf roids (bullet.x, bullet.y) (fst checkBullet)
                        else remainingRoids
            bulletsLeft = if (snd <| checkBullet)
                          then remainingBullets
                          else bullet::remainingBullets
        in checkIfAsteroidsNotClose roids (tail bullets) roidsLeft bulletsLeft

-- checks a bullet against all asteroids
-- returns remaining asteroids and whether an asteroid was
-- founds close to a bullet
-- if an asteroid was found, the list of remainingRoids will omit
-- that one asteroid
checkRoidsLeft: Bullet -> [Asteroid] -> [Asteroid] -> Bool -> ([Asteroid], Bool)
checkRoidsLeft bullet roids remainingRoids found = 
    case roids of
      [] -> (remainingRoids, False)
      otherwise -> 
          -- no asteroid close
          if | (roidFarEnough bullet (head roids)) ->
                   checkRoidsLeft bullet 
                                  (tail roids) 
                                  ((head roids)::remainingRoids) 
                                  False
          -- close asteroid found
             | (not (roidFarEnough bullet (head roids))) || found ->
                   (remainingRoids ++ (tail roids), True)
 

   
-- returns true if roid is far enough from bullet,
-- false otherwise
roidFarEnough: Bullet -> Asteroid -> Bool
roidFarEnough bullet roid =
    let xdif = (abs (bullet.x - roid.x)) > 0.5
        ydif = (abs (bullet.y - roid.y)) > 0.5
    in xdif && ydif
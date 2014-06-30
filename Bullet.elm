module Bullet where
import Playground.Input (..)
import Keyboard.Keys as Keys
import Ship (..)

type Bullet = { x : Float, 
                y : Float,
               vx : Float, 
               vy : Float,
            speed : Float,
             size : Float,
             angle: Float, 
        birthtime : Float}

defaultBullet: Bullet
defaultBullet = {x = 0, 
                 y = 0,
                vx = 0, 
                vy = 0,
             speed = 0,
              size = 0,
             angle = 0,
         birthtime = 0}

bullet : Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Bullet
bullet x y vx vy speed size angle birthtime = { x = x, 
                                                y = y,
                                               vx = vx,
                                               vy = vy,
                                            speed = speed,
                                             size = size,
                                            angle = angle,
                                        birthtime = birthtime }

-- applies physics to a bullet
physics : Bullet -> Bullet
physics b = if |  b.birthtime > 200 -> {b | size <- 0}
               |        otherwise -> { b | x <- b.x + (b.vx * b.speed),
                                           y <- b.y + (b.vy * b.speed),
                                   birthtime <- b.birthtime + 1}

-- applied physics to each bullet in list
updateAll: [Bullet] -> [Bullet]
updateAll = map physics


-- determines whether a bullet is young enough to be kept
-- predicate in filter function in checkBulletTime
youngEnough: Bullet -> Bool
youngEnough bullet = bullet.birthtime < 100

-- filters a list of bullets based on birthtime
-- eliminates old bullets
checkBulletTime: [Bullet] -> [Bullet]
checkBulletTime bullets = filter youngEnough bullets

-- updates all bullets
update : Input -> [Bullet] -> Ship {} -> [Bullet]
update input bullets ship = 
    let bullets' = checkBulletTime bullets
    in case input of
      Key key ->
          if | key `Keys.equals` Keys.space ->
                                   addBullet bullets' ship
             | otherwise -> bullets'
      Passive t -> updateAll bullets'
      otherwise -> bullets'


render : Bullet -> Form
render {x, y, size} = circle size |> filled green |> move (x,y)




--Adds a bullet to the list of bullets
addBullet: [Bullet] -> Ship {} -> [Bullet]
addBullet bullets ship = (createBullet ship)::bullets


--creates a new bullet
createBullet: Ship {} -> Bullet
createBullet ship  = { defaultBullet | x <- ship.x, 
                                       y <- ship.y,
                                       vx <- cos(ship.angle),
                                       vy <- sin(ship.angle),
                                    speed <- 15,
                                     size <- 5,
                                    angle <- ship.angle,
                                birthtime <- 0}
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

physics : Bullet -> Bullet
physics b = if |  b.birthtime > 1 -> {b | size <- 0}
               |        otherwise -> { b | x <- b.x + b.vx,
                                           y <- b.y + b.vy,
                                   birthtime <- b.birthtime + 1}
updateAll: [Bullet] -> [Bullet]
updateAll = map physics


update : Input -> [Bullet] -> Ship {} -> [Bullet]
update input bullets ship = 
    case input of
      Key key ->
          if | key `Keys.equals` Keys.space ->
                                   addBullet bullets ship
             | otherwise -> bullets
      Passive t -> updateAll bullets
      otherwise -> bullets

render : Bullet -> Form
render {x, y, size} = circle size |> filled green |> move (x,y)


--
--
--
--
--
--
--
--
-- COPIED FROM SHIP

--Adds a bullet to the ships bullets
addBullet: [Bullet] -> Ship {} -> [Bullet]
addBullet bullets ship = (createBullet ship)::bullets

-- getBullets: GameState -> [Bullet]
-- getBullets s = s.bullets

createBullet: Ship {} -> Bullet
createBullet ship  = { defaultBullet | x <- ship.x, 
                                       y <- ship.y,
                                       vx <- ship.vy * 2,
                                       vy <- ship.vy * 2,
                                    speed <- ship.speed,
                                     size <- 5,
                                    angle <- ship.angle,
                                birthtime <- 0}
module Bullet where

type Bullet = { x : Float, y : Float,
               vx : Float, vy : Float,
               speed : Float,
               size : Float, angle: Float, 
               birthtime : Float}
default: Bullet
default = {x = 0, y = 0, vx = 0, vy = 0, speed = 0, size = 0, angle = 0, birthtime = 0}


update : Bullet -> Time -> Bullet
update bullet time = if | time - bullet.birthtime > 2000 -> bullet
                        | otherwise -> bullet
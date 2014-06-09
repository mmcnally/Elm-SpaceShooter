module Asteroid where

type Asteroid = { x : Float,
                  y : Float,
                  vx : Float,
                  vy : Float }

asteroid : Float -> Float -> Float -> Float -> Asteroid
asteroid x y vx vy = { x = x, y = y, vx = vx, vy = vy }

physics : Asteroid -> Asteroid
physics asteroid =
    { asteroid | x <- asteroid.x + asteroid.vx,
                 y <- asteroid.y + asteroid.vy }

updateAll : [Asteroid] -> [Asteroid]
updateAll = map physics

render : Asteroid -> Form
render {x, y} = circle 10 |> filled black |> move (x, y)
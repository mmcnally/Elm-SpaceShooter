module Radar where
import Asteroid (..)
import Enemy (..)
import Bullet (..)

type Coordinate a = { a | x: Float, y: Float }

emptyCoordinate: Coordinate {}
emptyCoordinate = { x = 0, y = 0 }

makeCoordinate: Coordinate a -> Coordinate {}
makeCoordinate {x, y} = { x = x, y = y }



update: [Asteroid] -> [EnemyShip {}] -> [Bullet] -> [Coordinate {}]
update roids enemies bullets =
    let roids' = map makeCoordinate roids
        enemies' = map makeCoordinate enemies
        bullets' = map makeCoordinate bullets
    in roids' ++ enemies' ++ bullets'

renderBackground: [Form]
renderBackground = 
    let outlineColor = charcoal
        backgroundColor = darkCharcoal

        circles = 
            let form = 
              toForm <|
              collage 1500 1000 [
                    move (525, -180) <| filled backgroundColor <| circle 100,
                    move (525, -180) <| filled blue (circle 3),
                    move (525, -180) <| outlined (solid outlineColor) (circle 10),
                    move (525, -180) <| outlined (solid outlineColor) (circle 20),
                    move (525, -180) <| outlined (solid outlineColor) (circle 30),
                    move (525, -180) <| outlined (solid outlineColor) (circle 40),
                    move (525, -180) <| outlined (solid outlineColor) (circle 50),
                    move (525, -180) <| outlined (solid outlineColor) (circle 60),
                    move (525, -180) <| outlined (solid outlineColor) (circle 70),
                    move (525, -180) <| outlined (solid outlineColor) (circle 80),
                    move (525, -180) <| outlined (solid outlineColor) (circle 90) ]
            in [form]
    in circles

render: Float -> Float -> Coordinate {} -> Form
render shipX shipY coordinate = renderPoint shipX shipY coordinate
  


renderPoint: Float -> Float -> Coordinate {} -> Form
renderPoint shipX shipY coordinate = 
    let xMove = (shipX - coordinate.x) / 20
        yMove = (shipY - coordinate.y) / 20
    in move (525 + xMove , -180 + yMove) <| filled gray <| circle 1
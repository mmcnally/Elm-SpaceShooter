module Radar where
import Asteroid (..)
import Enemy (..)
import Bullet (..)
import Ship (..)
import QuadTree (..)

type Coordinate a = { a | x: Float, y: Float }

radarSize = 100

emptyCoordinate: Coordinate {}
emptyCoordinate = { x = 0, y = 0 }

makeCoordinate: Coordinate a -> Coordinate {}
makeCoordinate {x, y} = { x = x, y = y }

tooFar: Ship {} -> Coordinate {} -> Bool
tooFar ship coordinate =  
    let xMove = (coordinate.x - ship.x) / 20
        yMove = (coordinate.y - ship.y) / 20
    in if sqrt ((xMove ^ 2) + (yMove ^ 2)) > (radarSize - 1)
       then False
       else True


update: QuadTree Asteroid -> QuadTree (EnemyShip {}) -> [Bullet] -> Ship {} -> [Coordinate {}]
update roids enemies bullets ship =
    let roids' = treeToList (treeMap makeCoordinate roids)
        -- can't improve this function until other things are
        -- in quadtree form, since quadtrees don't work in lists
        enemies' = treeToList (treeMap makeCoordinate enemies)
        bullets' = map makeCoordinate bullets
        coordinates = roids' ++ enemies' ++ bullets'
        coordinates' = filter (tooFar ship) coordinates
    in coordinates'

renderBackground: [Form]
renderBackground = 
    let outlineColor = charcoal
        backgroundColor = darkCharcoal

        circles = 
            let form = 
              toForm <|
              collage 1500 1000 [
                    move (525, -180) <| filled backgroundColor <| circle radarSize,
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
    let xMove = (coordinate.x - shipX) / 20
        yMove = (coordinate.y - shipY) / 20
    in move (525 + xMove , -180 + yMove) <| filled gray <| circle 1
       
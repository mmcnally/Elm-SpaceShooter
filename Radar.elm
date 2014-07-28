module Radar where
import GameState (..)

update: GameState -> GameState
update state = state

render: GameState -> Form
render state = 
    let outlineColor = charcoal
        backgroundColor = darkCharcoal
    in toForm <|
       collage 300 600 [
                    move (0, -180) <| filled backgroundColor <| circle 100,
                    move (0, -180) <| filled outlineColor (circle 1),
                    move (0, -180) <| outlined (solid outlineColor) (circle 10),
                    move (0, -180) <| outlined (solid outlineColor) (circle 20),
                    move (0, -180) <| outlined (solid outlineColor) (circle 30),
                    move (0, -180) <| outlined (solid outlineColor) (circle 40),
                    move (0, -180) <| outlined (solid outlineColor) (circle 50),
                    move (0, -180) <| outlined (solid outlineColor) (circle 60),
                    move (0, -180) <| outlined (solid outlineColor) (circle 70),
                    move (0, -180) <| outlined (solid outlineColor) (circle 80),
                    move (0, -180) <| outlined (solid outlineColor) (circle 90) ]
module Radar where
import GameState (..)

render: GameState -> Form
render state = toForm <|
               collage 300 600 [
                            move (0, -180) <| filled darkCharcoal <| circle 100 ]
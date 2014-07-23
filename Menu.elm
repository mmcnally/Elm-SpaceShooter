module Menu where
import Text (..)
import Mouse (..)
import GameState (..)
import PlayGround (..)
import PlayGround.Input (..)

render: [Form]
render = 
    let background = [filled blue <| rect 300 400]
        text = [move (0, 150) <| 
                       toForm <| 
                     centered <| 
                     height 40 (toText "Start Game") ]
    in background ++ text

update: GameState -> Input -> GameState
update state input = state
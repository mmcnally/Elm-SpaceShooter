module Menu where
import Text (..)
import Mouse (..)
import GameState (..)
import Playground (..)
import Playground.Input (..)


render: [Form]
render = 
    let background = [filled blue <| rect 300 400]
        text = [move (0, 150) <| 
                       toForm <| 
                     centered <| 
                     height 40 (toText "Start Game") ]
    in background ++ text

update: RealWorld -> Input -> GameState -> GameState
update realWorld input state  = 
    let x = realWorld.mouse.x
        y = realWorld.mouse.y
    in case input of 
      Click -> if | (x < 100 && x > -100 && y < 170 && y > 125) -> 
                                            { state | isPlaying <- True }
                  | otherwise -> state
      otherwise -> state
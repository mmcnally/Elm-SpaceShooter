module Menu where
import Text (..)
import Mouse (..)
import GameState (..)
import Playground (..)
import Playground.Input (..)


render: [Form]
render = 
    let background = [filled blue <| rect 300 400]
        startTextBackground = [move (0, 150) <| filled darkBlue <| rect 200 50]
        startText = [move (0, 150) <| 
                       toForm <| 
                     centered <| 
                     height 40 (toText "Start Game") ]
    in background ++ startTextBackground ++ startText

update: RealWorld -> Input -> GameState -> GameState
update realWorld input state  = 
    let x = realWorld.mouse.x
        y = realWorld.mouse.y
    in case input of 
      Click -> if | (x < 100 && x > -100 && y < 175 && y > 125) -> 
                                            { state | isPlaying <- True }
                  | otherwise -> state
      otherwise -> state
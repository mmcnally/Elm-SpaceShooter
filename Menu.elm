module Menu where
import Text (..)
import Mouse (..)
import GameState (..)
import Playground (..)
import Playground.Input (..)


render: GameState -> [Form]
render state = 
    let background = [filled blue <| rect 300 400]
        num = snd state.isPlaying
        color = if num == 0 then green else darkBlue
        startTextBackground = [move (0, 150) <| filled color <| rect 200 50]
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
                                            { state | isPlaying <- (True, -1) }
                  | otherwise -> state
      otherwise -> if (x < 100 && x > -100 && y < 175 && y > 125)
                   then {state | isPlaying <- (False, 0) }
                   else { state | isPlaying <- (False, -1) }
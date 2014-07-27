module Menu where
import Text (..)
import Mouse (..)
import GameState (..)
import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys

render: GameState -> [Form]
render state = 
    let menuBackground = [filled darkPurple <| rect 300 400]
        num = snd state.isPlaying
        color = if num == 0 then darkOrange else purple
        background = [filled black <| rect 1500 1500]
        startTextBackground = [move (0, 150) <| filled color <| rect 200 50]
        startText = [move (0, 150) <| 
                            toForm <| 
                          centered <| 
                     height 40 (toText "Start Game") ]
       
    in background ++ menuBackground ++ startTextBackground ++ startText

update: RealWorld -> Input -> GameState -> GameState
update realWorld input state  = 
    let x = realWorld.mouse.x
        y = realWorld.mouse.y
        flip = not (fst state.isPlaying)
    in case input of 
      Click -> if | (x < 100 && x > -100 && y < 175 && y > 125) -> 
                           { state | isPlaying <- (True, -1) }
                  | otherwise -> state
      Tap key -> if key `Keys.equals` Keys.p
                 then { state | isPlaying <- (flip, -1) }
                 else state
      otherwise -> if (x < 100 && x > -100 && y < 175 && y > 125)
                   then {state | isPlaying <- (fst state.isPlaying, 0) }
                   else { state | isPlaying <- (fst state.isPlaying, -1) }
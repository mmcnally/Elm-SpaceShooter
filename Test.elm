import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys

type GameState = { x : Float, 
                   y : Float }

initialState : GameState
initialState = { x = 0, y = 0 }

render : GameState -> [Form]
render state = 
    let ship = ngon 3 20 |> filled green |> move (state.x, state.y)
    in [ship]

moveSpeed = 2

update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    case input of
      Key key -> if | key `Keys.equal` Keys.arrowLeft -> 
                                       { state | x <- state.x - moveSpeed }
                    | key `Keys.equal` Keys.arrowRight -> 
                                       { state | x <- state.x + moveSpeed }
                    | otherwise -> state
      otherwise -> state

main = play { initialState = initialState, 
              render = render,
              update = update }
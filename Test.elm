import Playground (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
import GameState (..)
import Ship (..)

render : GameState -> [Form]
render state = 
    let ship = state.ship 
        shipForm = ngon 3 20 |> filled green |> move (ship.x, ship.y)
    in [shipForm]

update : RealWorld -> Input -> GameState -> GameState
update realWorld input state =
    let ship' = updateShip input state.ship in
    case input of
      otherwise -> {state | ship <- ship' }

main = play { initialState = initialState, 
              render = render,
              update = update }
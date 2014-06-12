import Playground (..)
import GameState (initialState)
import Render (render)
import Update (update)
 
main : Signal Element
main = play { initialState = initialState, 
              render = render,
              update = update } 
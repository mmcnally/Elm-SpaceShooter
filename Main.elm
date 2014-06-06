import Playground (..)
import GameState (initialState)
import Render (render)
import Update (update)
 
main = play { initialState = initialState, 
              render = render,
              update = update }


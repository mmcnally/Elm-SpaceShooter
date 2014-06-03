module Ship where
import Playground.Input (..)
import Keyboard.Keys as Keys

type Ship = { x : Float, y : Float,
              vx : Float, vy : Float }

initialShip : Ship
initialShip = { x = 0, y = 0, vx = 0, vy = 0 }

speed : Float
speed = 2


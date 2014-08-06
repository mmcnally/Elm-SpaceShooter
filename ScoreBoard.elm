module ScoreBoard where
import GameState (..)

{-
  ***Guide for type of hit***
  1 - Asteroid
  2 - Enemy Ship
-}

targetHit: Int -> GameState -> GameState
targetHit hitNum state =
    { state | score <- (state.score + (50 * hitNum)) }

renderScore: GameState -> [Form]
renderScore state =
   let scoreText = move (300,300) <| toForm <| asText <| state.score 
       textBox = move (300, 300) <| filled white <| (rect 50 50)
   in
     [textBox, scoreText]
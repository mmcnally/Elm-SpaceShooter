module Console where
import GameState (..)

renderFilter: GameState -> GameState
renderFilter state = 
    let pred = tooClose state.ship
        asteroids' = filter pred state.asteroids
        enemies' = filter pred state.enemies
        stars' = filter pred state.stars
        farAsteroids' = filter pred state.farAsteroids
    in { state | asteroids    <- asteroids',
                 enemies      <- enemies',
                 stars        <- stars',
                 farAsteroids <- farAsteroids' }



tooClose ship thing = 
    if (abs (ship.x - thing.x)) < 400 && (abs (ship.y - thing.y)) < 300
    then True
    else False
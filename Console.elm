module Console where
import GameState (..)


-- only allow objects withing 800 x 600 view to render
renderFilter: GameState -> GameState
renderFilter state = 
    let pred = closeEnough state.ship
        asteroids' = filter pred state.asteroids
        enemies' = filter pred state.enemies
        stars' = filter pred state.stars
    in { state | asteroids    <- asteroids',
                 enemies      <- enemies',
                 stars        <- stars' }


renderConsole: GameState -> Form
renderConsole state = toForm <|
                      collage 1400 1000 [ 
                                move (525, 0) <| filled purple <| rect 250 1000,
                                move (-525, 0) <| filled purple <| rect 250 1000 ]


--decides if thing is close enough to be rendered
closeEnough ship thing = 
    if (abs (ship.x - thing.x)) < 400 && (abs (ship.y - thing.y)) < 300
    then True
    else False
module Console where
import GameState (..)
import Radar
import QuadTree (..)
import Enemy (..)

-- only allow objects withing 800 x 600 view to render
renderFilter: GameState -> GameState
renderFilter state = 
    let pred = closeEnough state.ship
        asteroids' = treeFilter pred state.asteroids
        enemies' = treeFilter pred state.enemies
        --enemyCoordinates = map toCoordinate enemies'
        stars' = filter pred state.stars
    in { state | asteroids    <- asteroids',
                 enemies      <- enemies',
                 stars        <- stars' }


renderConsole: GameState -> [Form]
renderConsole state = 
    let radarBackground = Radar.renderBackground
        radarForms = map (Radar.render state.ship.x state.ship.y) state.radarForms
        console = 
            [toForm <|
            collage 1400 1000 [ 
                         move (525, 0) <| filled darkPurple <| rect 250 1000,
                         move (-525, 0) <| filled darkPurple <| rect 250 1000] ]
    in console ++ radarBackground ++ radarForms
        


--decides if thing is close enough to be rendered
closeEnough ship thing = 
    if (abs (ship.x - thing.x)) < 400 && (abs (ship.y - thing.y)) < 300
    then True
    else False
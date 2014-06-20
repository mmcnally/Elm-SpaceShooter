--TEST *2
module Ship where
import Bullet (..)
import Playground.Input (..)
import Keyboard.Keys as Keys
-- import GameState (..)

type Ship a = { a | x : Float,
                    y : Float,
                    vx : Float,
                    vy : Float,
                    color : ShipColor,
                    speed : Float,
                    size : Float,
                    angle: Float,
                    accelerate: Float,
                    damage : Int, 
                    bullets: [Bullet]}
              
type ShipColor = { body : Color, window : Color, body2 : Color }

shipColor = { body = blue, window = grey, body2 = green } 

enemyShipColor = { shipColor | body <- red,
                               body2 <- orange } 
enemy: Ship {}
enemy = { x = 0,
          y = 0,
          vx = 0,
          vy = 0,
          color = enemyShipColor,
          speed = 2,
          size = 10,
          angle = 0,
          accelerate = 0,
          damage = 0,
          bullets = [] }

initialShip : Ship {}
initialShip = { x = 0, 
                y = 0, 
                vx = 0, 
                vy = 0, 
                color = shipColor, 
                speed = 0,
                size = 20,
                angle = pi/2,
                accelerate = 0,

                damage = 0, 
                bullets = [] }

render : Ship {} -> Form
render {x, y, color, size, angle} = 
  group [ ngon 3 size |> filled color.body,
          ngon 3 (size * 0.7) |> filled color.window |> move (size * 0.1, 0),
          ngon 3 (size * 0.2) |> filled color.body2 ] |> rotate angle |> move (x, y)

renderHealth : Ship {} -> Form
renderHealth {x, y, color, size, angle, damage} =
   
    if(damage == 0)
    then
        (outlined (dashed red) (rect 200 200))
    else
        (outlined (dashed red) (rect 200 200))

-- max possible speed of ship

maxSpeed = 5

-- accelerates ship if accelerate is true
-- otherwise it slows down ship
accelerate: Ship {} -> Ship {}
accelerate ship = 
    let dir = ship.speed / (abs ship.speed) in
    if | (ship.accelerate /= 0) && 
         (abs ship.speed) < (abs ship.accelerate) -> 
              { ship | speed <- ship.accelerate }
        | (ship.accelerate /= 0) -> 
              { ship | speed <- if (abs ship.speed) < maxSpeed
                                then ship.speed + ((abs ship.speed) * ship.accelerate)
                                else dir * maxSpeed }
       | otherwise -> { ship | speed <- if | (abs ship.speed) < 0.025 -> 0
                             | otherwise -> ship.speed - (ship.speed * 0.005) } 
 
--- applies physics to a ship 
physics : Ship {} -> Ship {}
physics ship = 
     let ship' = accelerate ship
     in { ship' | x <- ship'.x + (ship'.vx * ship'.speed),
                  y <- ship'.y + (ship'.vy * ship'.speed) }

-- adjusts ship angle based on arrow keys pressed
adjustAngle: Ship {} -> Float -> Ship {}
adjustAngle ship num = 
    let ship' = { ship | angle <- if | ship.angle > (2 * pi) -> 0
                                     | ship.angle < 0 -> 2 * pi
                                     | otherwise -> ship.angle}
    in { ship' | angle <- if num > 0
                          then ship'.angle - (pi/30)
                          else ship'.angle + (pi/30) }


-- enemyAI: Gamestate -> Ship -> Ship
-- enemyAI state enemyShip = enemyShip


moveEnemies: Float -> Float -> Ship {} -> Ship {}
moveEnemies x y enemyShip = { enemyShip | x <- enemyShip.x + 5,
                                          y <- enemyShip.y - 5 }

--Struck out so it works
addBullet: Ship {} -> Ship {}
addBullet ship = {ship | bullets <- (createBullet ship)::ship.bullets }



createBullet: Ship {} -> Bullet
createBullet ship = { defaultBullet | x <- ship.x, 
                                      y <- ship.y,
                                    vx <- ship.vy,
                                     vy <- ship.vy,
                                  speed <- ship.speed,
                                   size <- 5,
                                  angle <- ship.angle,
                              birthtime <- 0}


update : Input -> Ship {} -> Ship {}
update input ship =
  -- let enemyShip' = map moveEnemies ship.x ship.y enemyShip
  -- in 
    case input of
      Key key ->
        if | key `Keys.equal` Keys.arrowUp -> 
                      { ship | vx <- cos(ship.angle),
                                vy <- sin(ship.angle),
                                accelerate <- 0.25 }
           | key `Keys.equal` Keys.arrowDown -> 
                      { ship | vx <- cos(ship.angle),
                               vy <- sin(ship.angle),
                               accelerate <- (-0.25) }
           | key `Keys.equal` Keys.arrowLeft -> 
                                adjustAngle ship (-1)
           | key `Keys.equal` Keys.arrowRight ->
                                adjustAngle ship (1)
           -- struck out so it works
           | key `Keys.equal` Keys.space  ->
                                addBullet ship                                
           | otherwise -> ship
      Passive t ->  let ship' = physics ship
                    in { ship' | accelerate <- 0 }
      otherwise -> ship

module Ship where
--import Bullet (..)
import Playground.Input (..)
import Keyboard.Keys as Keys

type Ship a = { a | x : Float,
                    y : Float,
                    vx : Float,
                    vy : Float,
                    color : ShipColor,
                    speed : Float,
                    size : Float,
                    angle: Float,
                    accelerate: Float,
                    damage : Int }
                   -- bullets: [Bullet]}
              
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
          damage = 0 }
          -- bullets = [] }

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
                damage = 0 }
                -- bullets = [] }

render : Ship a -> [Form]
render ship = 
  let healthMeter = renderHealth ship
  in
  [group [ ngon 3 ship.size |> filled ship.color.body,
          ngon 3 (ship.size * 0.7) |> filled ship.color.window |> move (ship.size * 0.1, 0),
          ngon 3 (ship.size * 0.2) |> filled ship.color.body2 ] |> rotate ship.angle |> move (ship.x, ship.y),
  healthMeter |> move (ship.x, ship.y) ]

renderHealth : Ship a -> Form
renderHealth {damage} =
   
    if(damage == 0)
    then
        let barSegment = outlined (dashed red) (rect 100 15)
            bar = group [barSegment,
                         move (110,0) barSegment,
                         move (220, 0) barSegment,
                         move (330, 0) barSegment,
                         move (440, 0) barSegment ]
        in
        (move (-230, -300) bar)
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


-- COMMENTED OUT CODE BELOW NOW IN BULLET.ELM 

-- Adds a bullet to the ships bullets
-- addBullet: Ship {} -> Ship {}
-- addBullet ship = {ship | bullets <- (createBullet ship)::ship.bullets }

-- getBullets: Ship {} -> [Bullet]
-- getBullets s = s.bullets

-- createBullet: Ship {} -> Bullet
-- createBullet ship = { defaultBullet | x <- ship.x, 
--                                       y <- ship.y,
--                                     vx <- ship.vy * 2,
--                                      vy <- ship.vy * 2,
--                                   speed <- ship.speed,
--                                    size <- 5,
--                                   angle <- ship.angle,
--                               birthtime <- 0}


update : Input -> Ship {} -> Ship {}
update input ship =
    case input of
      Key key ->
        if | key `Keys.equals` Keys.arrowUp -> 
                      { ship | vx <- cos(ship.angle),
                                vy <- sin(ship.angle),
                                accelerate <- 0.25 }
           | key `Keys.equals` Keys.arrowDown -> 
                      { ship | vx <- cos(ship.angle),
                               vy <- sin(ship.angle),
                               accelerate <- (-0.25) }
           | key `Keys.equals` Keys.arrowLeft -> 
                                adjustAngle ship (-1)
           | key `Keys.equals` Keys.arrowRight ->
                                adjustAngle ship (1)
           --MOVED TO BULLET.ELM
           -- | key `Keys.equals` Keys.space  ->
           --                      addBullet ship                                
           | otherwise -> ship
      Passive t ->  let ship' = physics ship
                    in { ship' | accelerate <- 0 }
      otherwise -> ship

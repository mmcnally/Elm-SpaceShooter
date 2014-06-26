Elm.Render = Elm.Render || {};
Elm.Render.make = function (_elm) {
   "use strict";
   _elm.Render = _elm.Render || {};
   if (_elm.Render.values)
   return _elm.Render.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Render";
   var Asteroid = Elm.Asteroid.make(_elm);
   var Basics = Elm.Basics.make(_elm);
   var Bullet = Elm.Bullet.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Enemy = Elm.Enemy.make(_elm);
   var GameState = Elm.GameState.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Ship = Elm.Ship.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var render = function (state) {
      return function () {
         var fixPosition = {ctor: "_Tuple2"
                           ,_0: 0 - state.ship.x
                           ,_1: 0 - state.ship.y};
         var bulletForms = A2(List.map,
         Bullet.render,
         Ship.getBullets(state.ship));
         var enemyForms = A2(List.map,
         Enemy.render,
         state.enemies);
         var asteroidForms = A2(List.map,
         Asteroid.render,
         state.asteroids);
         var shipForm = Ship.render(state.ship);
         var forms = _L.append(enemyForms,
         _L.append(asteroidForms,
         _L.append(shipForm,
         bulletForms)));
         return A2(List.map,
         Graphics.Collage.move(fixPosition),
         forms);
      }();
   };
   _elm.Render.values = {_op: _op
                        ,render: render};
   return _elm.Render.values;
};Elm.GameState = Elm.GameState || {};
Elm.GameState.make = function (_elm) {
   "use strict";
   _elm.GameState = _elm.GameState || {};
   if (_elm.GameState.values)
   return _elm.GameState.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "GameState";
   var Asteroid = Elm.Asteroid.make(_elm);
   var Basics = Elm.Basics.make(_elm);
   var Bullet = Elm.Bullet.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Enemy = Elm.Enemy.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Ship = Elm.Ship.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var initialState = {_: {}
                      ,asteroids: _L.fromArray([A4(Asteroid.asteroid,
                                               200,
                                               200,
                                               -0.5,
                                               -1)
                                               ,A4(Asteroid.asteroid,
                                               -200,
                                               200,
                                               0.1,
                                               -0.25)])
                      ,bullets: _L.fromArray([A8(Bullet.bullet,
                      200,
                      200,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0)])
                      ,enemies: _L.fromArray([_U.replace([["x"
                                                          ,50]
                                                         ,["y",50]
                                                         ,["speed",1.0]
                                                         ,["playerX",50]],
                                             Enemy.enemy)
                                             ,_U.replace([["x",-100]
                                                         ,["y",200]
                                                         ,["speed",0.4]],
                                             Enemy.enemy)
                                             ,_U.replace([["x",100]
                                                         ,["y",-150]
                                                         ,["speed",0.1]],
                                             Enemy.enemy)])
                      ,ship: Ship.initialShip};
   var GameState = F4(function (a,
   b,
   c,
   d) {
      return {_: {}
             ,asteroids: b
             ,bullets: d
             ,enemies: c
             ,ship: a};
   });
   _elm.GameState.values = {_op: _op
                           ,initialState: initialState
                           ,GameState: GameState};
   return _elm.GameState.values;
};Elm.Asteroid = Elm.Asteroid || {};
Elm.Asteroid.make = function (_elm) {
   "use strict";
   _elm.Asteroid = _elm.Asteroid || {};
   if (_elm.Asteroid.values)
   return _elm.Asteroid.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Asteroid";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var render = function (_v0) {
      return function () {
         return Graphics.Collage.move({ctor: "_Tuple2"
                                      ,_0: _v0.x
                                      ,_1: _v0.y})(Graphics.Collage.filled(Color.black)(Graphics.Collage.circle(10)));
      }();
   };
   var physics = function (asteroid) {
      return _U.replace([["x"
                         ,asteroid.x + asteroid.vx]
                        ,["y"
                         ,asteroid.y + asteroid.vy]],
      asteroid);
   };
   var updateAll = List.map(physics);
   var asteroid = F4(function (x,
   y,
   vx,
   vy) {
      return {_: {}
             ,vx: vx
             ,vy: vy
             ,x: x
             ,y: y};
   });
   var Asteroid = F4(function (a,
   b,
   c,
   d) {
      return {_: {}
             ,vx: c
             ,vy: d
             ,x: a
             ,y: b};
   });
   _elm.Asteroid.values = {_op: _op
                          ,asteroid: asteroid
                          ,physics: physics
                          ,updateAll: updateAll
                          ,render: render
                          ,Asteroid: Asteroid};
   return _elm.Asteroid.values;
};Elm.Enemy = Elm.Enemy || {};
Elm.Enemy.make = function (_elm) {
   "use strict";
   _elm.Enemy = _elm.Enemy || {};
   if (_elm.Enemy.values)
   return _elm.Enemy.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Enemy";
   var Basics = Elm.Basics.make(_elm);
   var Bullet = Elm.Bullet.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Ship = Elm.Ship.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var render = function (_v0) {
      return function () {
         return Graphics.Collage.move({ctor: "_Tuple2"
                                      ,_0: _v0.x
                                      ,_1: _v0.y})(Graphics.Collage.rotate(_v0.angle)(Graphics.Collage.group(_L.fromArray([Graphics.Collage.filled(_v0.color.body)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v0.size))
                                                                                                                          ,Graphics.Collage.move({ctor: "_Tuple2"
                                                                                                                                                 ,_0: _v0.size * 0.1
                                                                                                                                                 ,_1: 0})(Graphics.Collage.filled(_v0.color.window)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v0.size * 0.7)))
                                                                                                                          ,Graphics.Collage.filled(_v0.color.body2)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v0.size * 0.2))]))));
      }();
   };
   var clampify = function (angle) {
      return _U.cmp(angle,
      2 * Basics.pi) > 0 ? angle - 2 * Basics.pi : _U.cmp(angle,
      0) < 0 ? 2 * Basics.pi - angle : angle;
   };
   var slowAngle = F2(function (newAngle,
   ship) {
      return function () {
         var newAngle$ = clampify(newAngle);
         var diff = newAngle$ - ship.angle;
         return _U.cmp(diff,
         Basics.pi) < 0 && _U.cmp(diff,
         0 - Basics.pi) > 0 ? ship.angle + ship.intel * diff / 10000 : ship.angle + ship.intel * (diff + 2 * Basics.pi) / 10000;
      }();
   });
   var correctMovement = F3(function (thingToModify,
   incr,
   playNum) {
      return _U.eq(thingToModify + incr,
      playNum) ? incr + 0.1 : incr;
   });
   var adjustAngle = F3(function (ship,
   xChange,
   yChange) {
      return function () {
         var radius = Basics.sqrt(Math.pow(xChange,
         2) + Math.pow(yChange,2));
         var angle = Basics.abs(Basics.asin(yChange / radius));
         return _U.cmp(yChange,
         0) < 0 && _U.cmp(xChange,
         0) < 0 ? Basics.pi + angle : _U.cmp(yChange,
         0) > 0 && _U.cmp(xChange,
         0) < 0 ? Basics.pi - angle : _U.cmp(yChange,
         0) < 0 && _U.cmp(xChange,
         0) > 0 ? 2 * Basics.pi - angle : angle;
      }();
   });
   var physics = function (ship) {
      return function () {
         var increment = F2(function (numer,
         denom) {
            return _U.cmp(Basics.sqrt(Math.pow(numer,
            2) + Math.pow(denom,2)),
            ship.speed) > 0 ? A2(increment,
            numer * 0.95,
            denom * 0.95) : {_: {}
                            ,xInc: denom
                            ,yInc: numer};
         });
         var slopeDenominator = ship.playerX - ship.x;
         var slopeNumerator = ship.playerY - ship.y;
         var slope = slopeNumerator / slopeDenominator;
         var xInc = A2(increment,
         slopeNumerator,
         slopeDenominator).xInc;
         var xIncrement = A3(correctMovement,
         ship.x,
         xInc,
         ship.playerX);
         var yInc = A2(increment,
         slopeNumerator,
         slopeDenominator).yInc;
         var yIncrement = A3(correctMovement,
         ship.y,
         yInc,
         ship.playerY);
         return _U.replace([["x"
                            ,ship.x + xIncrement]
                           ,["y",ship.y + yIncrement]
                           ,["angle"
                            ,A2(slowAngle,
                            A3(adjustAngle,
                            ship,
                            xIncrement,
                            yIncrement),
                            ship)]],
         ship);
      }();
   };
   var shipAI = physics;
   var updateAll = List.map(shipAI);
   var enemyShipColor = _U.replace([["body"
                                    ,Color.red]
                                   ,["body2",Color.orange]],
   Ship.shipColor);
   var enemy = {_: {}
               ,accelerate: 0
               ,angle: 0
               ,bullets: _L.fromArray([])
               ,color: enemyShipColor
               ,damage: 0
               ,intel: 10
               ,playerX: 0
               ,playerY: 0
               ,size: 10
               ,speed: 0
               ,vx: 0
               ,vy: 0
               ,x: 0
               ,y: 0};
   _elm.Enemy.values = {_op: _op
                       ,enemyShipColor: enemyShipColor
                       ,enemy: enemy
                       ,adjustAngle: adjustAngle
                       ,correctMovement: correctMovement
                       ,clampify: clampify
                       ,slowAngle: slowAngle
                       ,physics: physics
                       ,shipAI: shipAI
                       ,updateAll: updateAll
                       ,render: render};
   return _elm.Enemy.values;
};Elm.Ship = Elm.Ship || {};
Elm.Ship.make = function (_elm) {
   "use strict";
   _elm.Ship = _elm.Ship || {};
   if (_elm.Ship.values)
   return _elm.Ship.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Ship";
   var Basics = Elm.Basics.make(_elm);
   var Bullet = Elm.Bullet.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var Keyboard = Keyboard || {};
   Keyboard.Keys = Elm.Keyboard.Keys.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Playground = Playground || {};
   Playground.Input = Elm.Playground.Input.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var createBullet = function (ship) {
      return _U.replace([["x"
                         ,ship.x]
                        ,["y",ship.y]
                        ,["vx",ship.vy]
                        ,["vy",ship.vy]
                        ,["speed",ship.speed]
                        ,["size",5]
                        ,["angle",ship.angle]
                        ,["birthtime",0]],
      Bullet.defaultBullet);
   };
   var getBullets = function (s) {
      return s.bullets;
   };
   var addBullet = function (ship) {
      return _U.replace([["bullets"
                         ,{ctor: "::"
                          ,_0: createBullet(ship)
                          ,_1: ship.bullets}]],
      ship);
   };
   var adjustAngle = F2(function (ship,
   num) {
      return function () {
         var ship$ = _U.replace([["angle"
                                 ,_U.cmp(ship.angle,
                                 2 * Basics.pi) > 0 ? 0 : _U.cmp(ship.angle,
                                 0) < 0 ? 2 * Basics.pi : ship.angle]],
         ship);
         return _U.replace([["angle"
                            ,_U.cmp(num,
                            0) > 0 ? ship$.angle - Basics.pi / 30 : ship$.angle + Basics.pi / 30]],
         ship$);
      }();
   });
   var maxSpeed = 5;
   var accelerate = function (ship) {
      return function () {
         var dir = ship.speed / Basics.abs(ship.speed);
         return !_U.eq(ship.accelerate,
         0) && _U.cmp(Basics.abs(ship.speed),
         Basics.abs(ship.accelerate)) < 0 ? _U.replace([["speed"
                                                        ,ship.accelerate]],
         ship) : !_U.eq(ship.accelerate,
         0) ? _U.replace([["speed"
                          ,_U.cmp(Basics.abs(ship.speed),
                          maxSpeed) < 0 ? ship.speed + Basics.abs(ship.speed) * ship.accelerate : dir * maxSpeed]],
         ship) : _U.replace([["speed"
                             ,_U.cmp(Basics.abs(ship.speed),
                             2.5e-2) < 0 ? 0 : ship.speed - ship.speed * 5.0e-3]],
         ship);
      }();
   };
   var physics = function (ship) {
      return function () {
         var ship$ = accelerate(ship);
         return _U.replace([["x"
                            ,ship$.x + ship$.vx * ship$.speed]
                           ,["y"
                            ,ship$.y + ship$.vy * ship$.speed]],
         ship$);
      }();
   };
   var update = F2(function (input,
   ship) {
      return function () {
         switch (input.ctor)
         {case "Key":
            return A2(Keyboard.Keys.equals,
              input._0,
              Keyboard.Keys.arrowUp) ? _U.replace([["vx"
                                                   ,Basics.cos(ship.angle)]
                                                  ,["vy",Basics.sin(ship.angle)]
                                                  ,["accelerate",0.25]],
              ship) : A2(Keyboard.Keys.equals,
              input._0,
              Keyboard.Keys.arrowDown) ? _U.replace([["vx"
                                                     ,Basics.cos(ship.angle)]
                                                    ,["vy"
                                                     ,Basics.sin(ship.angle)]
                                                    ,["accelerate",-0.25]],
              ship) : A2(Keyboard.Keys.equals,
              input._0,
              Keyboard.Keys.arrowLeft) ? A2(adjustAngle,
              ship,
              -1) : A2(Keyboard.Keys.equals,
              input._0,
              Keyboard.Keys.arrowRight) ? A2(adjustAngle,
              ship,
              1) : A2(Keyboard.Keys.equals,
              input._0,
              Keyboard.Keys.space) ? addBullet(ship) : ship;
            case "Passive":
            return function () {
                 var ship$ = physics(ship);
                 return _U.replace([["accelerate"
                                    ,0]],
                 ship$);
              }();}
         return ship;
      }();
   });
   var renderHealth = function (_v3) {
      return function () {
         return _U.eq(_v3.damage,
         0) ? function () {
            var barSegment = A2(Graphics.Collage.outlined,
            Graphics.Collage.dashed(Color.red),
            A2(Graphics.Collage.rect,
            100,
            15));
            var bar = Graphics.Collage.group(_L.fromArray([barSegment
                                                          ,A2(Graphics.Collage.move,
                                                          {ctor: "_Tuple2"
                                                          ,_0: 110
                                                          ,_1: 0},
                                                          barSegment)
                                                          ,A2(Graphics.Collage.move,
                                                          {ctor: "_Tuple2"
                                                          ,_0: 220
                                                          ,_1: 0},
                                                          barSegment)
                                                          ,A2(Graphics.Collage.move,
                                                          {ctor: "_Tuple2"
                                                          ,_0: 330
                                                          ,_1: 0},
                                                          barSegment)
                                                          ,A2(Graphics.Collage.move,
                                                          {ctor: "_Tuple2"
                                                          ,_0: 440
                                                          ,_1: 0},
                                                          barSegment)]));
            return A2(Graphics.Collage.move,
            {ctor: "_Tuple2"
            ,_0: -230
            ,_1: -300},
            bar);
         }() : A2(Graphics.Collage.outlined,
         Graphics.Collage.dashed(Color.red),
         A2(Graphics.Collage.rect,
         200,
         200));
      }();
   };
   var render = function (ship) {
      return function () {
         var healthMeter = renderHealth(ship);
         return _L.fromArray([Graphics.Collage.move({ctor: "_Tuple2"
                                                    ,_0: ship.x
                                                    ,_1: ship.y})(Graphics.Collage.rotate(ship.angle)(Graphics.Collage.group(_L.fromArray([Graphics.Collage.filled(ship.color.body)(A2(Graphics.Collage.ngon,
                                                                                                                                          3,
                                                                                                                                          ship.size))
                                                                                                                                          ,Graphics.Collage.move({ctor: "_Tuple2"
                                                                                                                                                                 ,_0: ship.size * 0.1
                                                                                                                                                                 ,_1: 0})(Graphics.Collage.filled(ship.color.window)(A2(Graphics.Collage.ngon,
                                                                                                                                          3,
                                                                                                                                          ship.size * 0.7)))
                                                                                                                                          ,Graphics.Collage.filled(ship.color.body2)(A2(Graphics.Collage.ngon,
                                                                                                                                          3,
                                                                                                                                          ship.size * 0.2))]))))
                             ,Graphics.Collage.move({ctor: "_Tuple2"
                                                    ,_0: ship.x
                                                    ,_1: ship.y})(healthMeter)]);
      }();
   };
   var shipColor = {_: {}
                   ,body: Color.blue
                   ,body2: Color.green
                   ,window: Color.grey};
   var enemyShipColor = _U.replace([["body"
                                    ,Color.red]
                                   ,["body2",Color.orange]],
   shipColor);
   var enemy = {_: {}
               ,accelerate: 0
               ,angle: 0
               ,bullets: _L.fromArray([])
               ,color: enemyShipColor
               ,damage: 0
               ,size: 10
               ,speed: 2
               ,vx: 0
               ,vy: 0
               ,x: 0
               ,y: 0};
   var initialShip = {_: {}
                     ,accelerate: 0
                     ,angle: Basics.pi / 2
                     ,bullets: _L.fromArray([])
                     ,color: shipColor
                     ,damage: 0
                     ,size: 20
                     ,speed: 0
                     ,vx: 0
                     ,vy: 0
                     ,x: 0
                     ,y: 0};
   var ShipColor = F3(function (a,
   b,
   c) {
      return {_: {}
             ,body: a
             ,body2: c
             ,window: b};
   });
   var Ship = function (a) {
      return function (b) {
         return function (c) {
            return function (d) {
               return function (e) {
                  return function (f) {
                     return function (g) {
                        return function (h) {
                           return function (i) {
                              return function (j) {
                                 return function (k) {
                                    return function (l) {
                                       return _U.insert("bullets",
                                       k,
                                       _U.insert("damage",
                                       j,
                                       _U.insert("accelerate",
                                       i,
                                       _U.insert("angle",
                                       h,
                                       _U.insert("size",
                                       g,
                                       _U.insert("speed",
                                       f,
                                       _U.insert("color",
                                       e,
                                       _U.insert("vy",
                                       d,
                                       _U.insert("vx",
                                       c,
                                       _U.insert("y",
                                       b,
                                       _U.insert("x",a,l)))))))))));
                                    };
                                 };
                              };
                           };
                        };
                     };
                  };
               };
            };
         };
      };
   };
   _elm.Ship.values = {_op: _op
                      ,shipColor: shipColor
                      ,enemyShipColor: enemyShipColor
                      ,enemy: enemy
                      ,initialShip: initialShip
                      ,render: render
                      ,renderHealth: renderHealth
                      ,maxSpeed: maxSpeed
                      ,accelerate: accelerate
                      ,physics: physics
                      ,adjustAngle: adjustAngle
                      ,addBullet: addBullet
                      ,getBullets: getBullets
                      ,createBullet: createBullet
                      ,update: update
                      ,Ship: Ship
                      ,ShipColor: ShipColor};
   return _elm.Ship.values;
};Elm.Bullet = Elm.Bullet || {};
Elm.Bullet.make = function (_elm) {
   "use strict";
   _elm.Bullet = _elm.Bullet || {};
   if (_elm.Bullet.values)
   return _elm.Bullet.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Bullet";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var render = function (_v0) {
      return function () {
         return Graphics.Collage.move({ctor: "_Tuple2"
                                      ,_0: _v0.x
                                      ,_1: _v0.y})(Graphics.Collage.filled(Color.green)(Graphics.Collage.circle(_v0.size)));
      }();
   };
   var physics = function (b) {
      return _U.cmp(b.birthtime,
      1) > 0 ? _U.replace([["size"
                           ,0]],
      b) : _U.replace([["x"
                       ,b.x + b.vx]
                      ,["y",b.y + b.vy]
                      ,["birthtime",b.birthtime + 1]],
      b);
   };
   var updateAll = List.map(physics);
   var bullet = F8(function (x,
   y,
   vx,
   vy,
   speed,
   size,
   angle,
   birthtime) {
      return {_: {}
             ,angle: angle
             ,birthtime: birthtime
             ,size: size
             ,speed: speed
             ,vx: vx
             ,vy: vy
             ,x: x
             ,y: y};
   });
   var defaultBullet = {_: {}
                       ,angle: 0
                       ,birthtime: 0
                       ,size: 0
                       ,speed: 0
                       ,vx: 0
                       ,vy: 0
                       ,x: 0
                       ,y: 0};
   var Bullet = F8(function (a,
   b,
   c,
   d,
   e,
   f,
   g,
   h) {
      return {_: {}
             ,angle: g
             ,birthtime: h
             ,size: f
             ,speed: e
             ,vx: c
             ,vy: d
             ,x: a
             ,y: b};
   });
   _elm.Bullet.values = {_op: _op
                        ,defaultBullet: defaultBullet
                        ,bullet: bullet
                        ,physics: physics
                        ,updateAll: updateAll
                        ,render: render
                        ,Bullet: Bullet};
   return _elm.Bullet.values;
};Elm.Playground = Elm.Playground || {};
Elm.Playground.Input = Elm.Playground.Input || {};
Elm.Playground.Input.make = function (_elm) {
   "use strict";
   _elm.Playground = _elm.Playground || {};
   _elm.Playground.Input = _elm.Playground.Input || {};
   if (_elm.Playground.Input.values)
   return _elm.Playground.Input.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Playground.Input";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var Keyboard = Keyboard || {};
   Keyboard.Keys = Elm.Keyboard.Keys.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var Passive = function (a) {
      return {ctor: "Passive"
             ,_0: a};
   };
   var MouseDown = {ctor: "MouseDown"};
   var Click = {ctor: "Click"};
   var Key = function (a) {
      return {ctor: "Key",_0: a};
   };
   var Tap = function (a) {
      return {ctor: "Tap",_0: a};
   };
   var RealWorld = F5(function (a,
   b,
   c,
   d,
   e) {
      return {_: {}
             ,bottom: c
             ,left: d
             ,mouse: e
             ,right: b
             ,top: a};
   });
   _elm.Playground.Input.values = {_op: _op
                                  ,Tap: Tap
                                  ,Key: Key
                                  ,Click: Click
                                  ,MouseDown: MouseDown
                                  ,Passive: Passive
                                  ,RealWorld: RealWorld};
   return _elm.Playground.Input.values;
};Elm.Keyboard = Elm.Keyboard || {};
Elm.Keyboard.Keys = Elm.Keyboard.Keys || {};
Elm.Keyboard.Keys.make = function (_elm) {
   "use strict";
   _elm.Keyboard = _elm.Keyboard || {};
   _elm.Keyboard.Keys = _elm.Keyboard.Keys || {};
   if (_elm.Keyboard.Keys.values)
   return _elm.Keyboard.Keys.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Keyboard.Keys";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var Keyboard = Elm.Keyboard.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var zero = {_: {}
              ,keyCode: 58
              ,name: "0"};
   var nine = {_: {}
              ,keyCode: 57
              ,name: "9"};
   var eight = {_: {}
               ,keyCode: 56
               ,name: "8"};
   var seven = {_: {}
               ,keyCode: 55
               ,name: "7"};
   var six = {_: {}
             ,keyCode: 54
             ,name: "6"};
   var five = {_: {}
              ,keyCode: 53
              ,name: "5"};
   var four = {_: {}
              ,keyCode: 52
              ,name: "4"};
   var three = {_: {}
               ,keyCode: 51
               ,name: "3"};
   var two = {_: {}
             ,keyCode: 50
             ,name: "2"};
   var one = {_: {}
             ,keyCode: 49
             ,name: "1"};
   var f10 = {_: {}
             ,keyCode: 121
             ,name: "F10"};
   var f9 = {_: {}
            ,keyCode: 120
            ,name: "F9"};
   var f8 = {_: {}
            ,keyCode: 119
            ,name: "F8"};
   var f4 = {_: {}
            ,keyCode: 115
            ,name: "F4"};
   var f2 = {_: {}
            ,keyCode: 113
            ,name: "F2"};
   var escape = {_: {}
                ,keyCode: 27
                ,name: "Escape"};
   var pageUp = {_: {}
                ,keyCode: 33
                ,name: "Page up"};
   var pageDown = {_: {}
                  ,keyCode: 34
                  ,name: "Page down"};
   var home = {_: {}
              ,keyCode: 36
              ,name: "Home"};
   var end = {_: {}
             ,keyCode: 35
             ,name: "End"};
   var insert = {_: {}
                ,keyCode: 45
                ,name: "Insert"};
   var $delete = {_: {}
                 ,keyCode: 46
                 ,name: "Delete"};
   var backspace = {_: {}
                   ,keyCode: 8
                   ,name: "Backspace"};
   var arrowDown = {_: {}
                   ,keyCode: 40
                   ,name: "Down arrow"};
   var arrowUp = {_: {}
                 ,keyCode: 38
                 ,name: "Up arrow"};
   var arrowLeft = {_: {}
                   ,keyCode: 39
                   ,name: "Left arrow"};
   var arrowRight = {_: {}
                    ,keyCode: 37
                    ,name: "Right arrow"};
   var enter = {_: {}
               ,keyCode: 13
               ,name: "Enter"};
   var space = {_: {}
               ,keyCode: 32
               ,name: "Space"};
   var commandRight = {_: {}
                      ,keyCode: 93
                      ,name: "Command right"};
   var commandLeft = {_: {}
                     ,keyCode: 91
                     ,name: "Command left"};
   var windows = {_: {}
                 ,keyCode: 91
                 ,name: "Windows"};
   var meta = {_: {}
              ,keyCode: 91
              ,name: "Meta"};
   var $super = {_: {}
                ,keyCode: 91
                ,name: "Super"};
   var tab = {_: {}
             ,keyCode: 9
             ,name: "Tab"};
   var shift = {_: {}
               ,keyCode: 16
               ,name: "Shift"};
   var ctrl = {_: {}
              ,keyCode: 17
              ,name: "Ctrl"};
   var z = {_: {}
           ,keyCode: 90
           ,name: "z"};
   var y = {_: {}
           ,keyCode: 89
           ,name: "y"};
   var x = {_: {}
           ,keyCode: 88
           ,name: "x"};
   var w = {_: {}
           ,keyCode: 87
           ,name: "w"};
   var v = {_: {}
           ,keyCode: 86
           ,name: "v"};
   var u = {_: {}
           ,keyCode: 85
           ,name: "u"};
   var t = {_: {}
           ,keyCode: 84
           ,name: "t"};
   var s = {_: {}
           ,keyCode: 83
           ,name: "s"};
   var r = {_: {}
           ,keyCode: 82
           ,name: "r"};
   var q = {_: {}
           ,keyCode: 81
           ,name: "q"};
   var p = {_: {}
           ,keyCode: 80
           ,name: "p"};
   var o = {_: {}
           ,keyCode: 79
           ,name: "o"};
   var n = {_: {}
           ,keyCode: 78
           ,name: "n"};
   var m = {_: {}
           ,keyCode: 77
           ,name: "m"};
   var l = {_: {}
           ,keyCode: 76
           ,name: "l"};
   var k = {_: {}
           ,keyCode: 75
           ,name: "k"};
   var j = {_: {}
           ,keyCode: 74
           ,name: "j"};
   var i = {_: {}
           ,keyCode: 73
           ,name: "i"};
   var h = {_: {}
           ,keyCode: 72
           ,name: "h"};
   var g = {_: {}
           ,keyCode: 71
           ,name: "g"};
   var f = {_: {}
           ,keyCode: 70
           ,name: "f"};
   var e = {_: {}
           ,keyCode: 69
           ,name: "e"};
   var d = {_: {}
           ,keyCode: 68
           ,name: "d"};
   var c = {_: {}
           ,keyCode: 67
           ,name: "b"};
   var b = {_: {}
           ,keyCode: 66
           ,name: "b"};
   var a = {_: {}
           ,keyCode: 65
           ,name: "a"};
   var isKeyDown = function (k) {
      return Keyboard.isDown(k.keyCode);
   };
   var directionKeys = F4(function (up,
   down,
   right,
   left) {
      return A4(Keyboard.directions,
      up.keyCode,
      down.keyCode,
      right.keyCode,
      left.keyCode);
   });
   var equals = F2(function (k0,
   k1) {
      return _U.eq(k0.keyCode,
      k1.keyCode);
   });
   var Key = F2(function (a,b) {
      return {_: {}
             ,keyCode: a
             ,name: b};
   });
   _elm.Keyboard.Keys.values = {_op: _op
                               ,equals: equals
                               ,directionKeys: directionKeys
                               ,isKeyDown: isKeyDown
                               ,a: a
                               ,b: b
                               ,c: c
                               ,d: d
                               ,e: e
                               ,f: f
                               ,g: g
                               ,h: h
                               ,i: i
                               ,j: j
                               ,k: k
                               ,l: l
                               ,m: m
                               ,n: n
                               ,o: o
                               ,p: p
                               ,q: q
                               ,r: r
                               ,s: s
                               ,t: t
                               ,u: u
                               ,v: v
                               ,w: w
                               ,x: x
                               ,y: y
                               ,z: z
                               ,ctrl: ctrl
                               ,shift: shift
                               ,tab: tab
                               ,$super: $super
                               ,meta: meta
                               ,windows: windows
                               ,commandLeft: commandLeft
                               ,commandRight: commandRight
                               ,space: space
                               ,enter: enter
                               ,arrowRight: arrowRight
                               ,arrowLeft: arrowLeft
                               ,arrowUp: arrowUp
                               ,arrowDown: arrowDown
                               ,backspace: backspace
                               ,$delete: $delete
                               ,insert: insert
                               ,end: end
                               ,home: home
                               ,pageDown: pageDown
                               ,pageUp: pageUp
                               ,escape: escape
                               ,f2: f2
                               ,f4: f4
                               ,f8: f8
                               ,f9: f9
                               ,f10: f10
                               ,one: one
                               ,two: two
                               ,three: three
                               ,four: four
                               ,five: five
                               ,six: six
                               ,seven: seven
                               ,eight: eight
                               ,nine: nine
                               ,zero: zero
                               ,Key: Key};
   return _elm.Keyboard.Keys.values;
};
Elm.Update = Elm.Update || {};
Elm.Update.make = function (_elm) {
   "use strict";
   _elm.Update = _elm.Update || {};
   if (_elm.Update.values)
   return _elm.Update.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Update";
   var Asteroid = Elm.Asteroid.make(_elm);
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Enemy = Elm.Enemy.make(_elm);
   var GameAI = Elm.GameAI.make(_elm);
   var GameState = Elm.GameState.make(_elm);
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
   var Playground = Elm.Playground.make(_elm);
   var Playground = Playground || {};
   Playground.Input = Elm.Playground.Input.make(_elm);
   var Ship = Elm.Ship.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var _op = {};
   var update = F3(function (realWorld,
   input,
   state) {
      return function () {
         var state$ = GameAI.updateState(state);
         var ship$ = A2(Ship.update,
         input,
         state$.ship);
         var asteroids$ = Asteroid.updateAll(state$.asteroids);
         var updateEnemies = function (ship) {
            return _U.replace([["playerX"
                               ,state$.ship.x]
                              ,["playerY",state$.ship.y]],
            ship);
         };
         var enemies$ = Enemy.updateAll(A2(List.map,
         updateEnemies,
         state$.enemies));
         return function () {
            return _U.replace([["ship"
                               ,ship$]
                              ,["asteroids",asteroids$]
                              ,["enemies",enemies$]],
            state$);
         }();
      }();
   });
   _elm.Update.values = {_op: _op
                        ,update: update};
   return _elm.Update.values;
};Elm.GameAI = Elm.GameAI || {};
Elm.GameAI.make = function (_elm) {
   "use strict";
   _elm.GameAI = _elm.GameAI || {};
   if (_elm.GameAI.values)
   return _elm.GameAI.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "GameAI";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Enemy = Elm.Enemy.make(_elm);
   var GameState = Elm.GameState.make(_elm);
   var Generator = Elm.Generator.make(_elm);
   var Generator = Generator || {};
   Generator.Standard = Elm.Generator.Standard.make(_elm);
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
   var seed = function (state) {
      return Basics.floor((state.ship.x + 0.7) * 345.0 + (state.ship.y + 8.4) * 837.0);
   };
   var randomNum = function (state) {
      return Basics.fst(Generator.$float(Generator.Standard.generator(seed(state))));
   };
   var addEnemy = function (state) {
      return _U.cmp(List.length(state.enemies),
      20) < 0 ? {ctor: "::"
                ,_0: _U.replace([["x"
                                 ,List.head(state.enemies).x * 1.5]
                                ,["y"
                                 ,List.head(state.enemies).y + 100]
                                ,["speed",randomNum(state)]],
                Enemy.enemy)
                ,_1: state.enemies} : state.enemies;
   };
   var updateState = function (state) {
      return _U.replace([["enemies"
                         ,addEnemy(state)]],
      state);
   };
   _elm.GameAI.values = {_op: _op
                        ,updateState: updateState
                        ,addEnemy: addEnemy
                        ,randomNum: randomNum
                        ,seed: seed};
   return _elm.GameAI.values;
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
   var GameState = F3(function (a,
   b,
   c) {
      return {_: {}
             ,asteroids: b
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
         var unAdjustedAngle = Basics.asin(yChange / radius);
         return _U.cmp(unAdjustedAngle,
         0) > 0 && _U.cmp(xChange,
         0) < 0 ? Basics.pi - unAdjustedAngle : _U.cmp(unAdjustedAngle,
         0) < 0 && _U.cmp(xChange,
         0) < 0 ? Basics.pi - unAdjustedAngle : unAdjustedAngle;
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
                            ,A3(adjustAngle,
                            ship,
                            xIncrement,
                            yIncrement)]],
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
   var addBullet = function (ship) {
      return _U.replace([["bullets"
                         ,{ctor: "::"
                          ,_0: createBullet(ship)
                          ,_1: ship.bullets}]],
      ship);
   };
   var moveEnemies = F3(function (x,
   y,
   enemyShip) {
      return _U.replace([["x"
                         ,enemyShip.x + 5]
                        ,["y",enemyShip.y - 5]],
      enemyShip);
   });
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
            return A2(Keyboard.Keys.equal,
              input._0,
              Keyboard.Keys.arrowUp) ? _U.replace([["vx"
                                                   ,Basics.cos(ship.angle)]
                                                  ,["vy",Basics.sin(ship.angle)]
                                                  ,["accelerate",0.25]],
              ship) : A2(Keyboard.Keys.equal,
              input._0,
              Keyboard.Keys.arrowDown) ? _U.replace([["vx"
                                                     ,Basics.cos(ship.angle)]
                                                    ,["vy"
                                                     ,Basics.sin(ship.angle)]
                                                    ,["accelerate",-0.25]],
              ship) : A2(Keyboard.Keys.equal,
              input._0,
              Keyboard.Keys.arrowLeft) ? A2(adjustAngle,
              ship,
              -1) : A2(Keyboard.Keys.equal,
              input._0,
              Keyboard.Keys.arrowRight) ? A2(adjustAngle,
              ship,
              1) : A2(Keyboard.Keys.equal,
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
   var render = function (_v3) {
      return function () {
         return Graphics.Collage.move({ctor: "_Tuple2"
                                      ,_0: _v3.x
                                      ,_1: _v3.y})(Graphics.Collage.rotate(_v3.angle)(Graphics.Collage.group(_L.fromArray([Graphics.Collage.filled(_v3.color.body)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v3.size))
                                                                                                                          ,Graphics.Collage.move({ctor: "_Tuple2"
                                                                                                                                                 ,_0: _v3.size * 0.1
                                                                                                                                                 ,_1: 0})(Graphics.Collage.filled(_v3.color.window)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v3.size * 0.7)))
                                                                                                                          ,Graphics.Collage.filled(_v3.color.body2)(A2(Graphics.Collage.ngon,
                                                                                                                          3,
                                                                                                                          _v3.size * 0.2))]))));
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
                                    return _U.insert("bullets",
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
                                    _U.insert("x",a,k))))))))));
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
                      ,maxSpeed: maxSpeed
                      ,accelerate: accelerate
                      ,physics: physics
                      ,adjustAngle: adjustAngle
                      ,moveEnemies: moveEnemies
                      ,addBullet: addBullet
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
                        ,Bullet: Bullet};
   return _elm.Bullet.values;
};Elm.Generator = Elm.Generator || {};
Elm.Generator.Standard = Elm.Generator.Standard || {};
Elm.Generator.Standard.make = function (_elm) {
   "use strict";
   _elm.Generator = _elm.Generator || {};
   _elm.Generator.Standard = _elm.Generator.Standard || {};
   if (_elm.Generator.Standard.values)
   return _elm.Generator.Standard.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Generator.Standard";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Generator = Elm.Generator.make(_elm);
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
   var magicNum8 = 2147483562;
   var stdRange = function (_v0) {
      return function () {
         return {ctor: "_Tuple2"
                ,_0: 0
                ,_1: magicNum8};
      }();
   };
   var magicNum7 = 2137383399;
   var magicNum6 = 2147483563;
   var magicNum5 = 3791;
   var magicNum4 = 40692;
   var magicNum3 = 52774;
   var magicNum2 = 12211;
   var magicNum1 = 53668;
   var magicNum0 = 40014;
   var Standard = F2(function (a,
   b) {
      return {ctor: "Standard"
             ,_0: a
             ,_1: b};
   });
   var mkStdGen = function (s$) {
      return function () {
         var s = A2(Basics.max,
         s$,
         0 - s$);
         var q = s / (magicNum6 - 1) | 0;
         var s2 = A2(Basics.mod,
         q,
         magicNum7 - 1);
         var s1 = A2(Basics.mod,
         s,
         magicNum6 - 1);
         return A2(Standard,
         s1 + 1,
         s2 + 1);
      }();
   };
   var stdNext = function (_v2) {
      return function () {
         switch (_v2.ctor)
         {case "Standard":
            return function () {
                 var k$ = _v2._1 / magicNum3 | 0;
                 var s2$ = magicNum4 * (_v2._1 - k$ * magicNum3) - k$ * magicNum5;
                 var s2$$ = _U.cmp(s2$,
                 0) < 0 ? s2$ + magicNum7 : s2$;
                 var k = _v2._0 / magicNum1 | 0;
                 var s1$ = magicNum0 * (_v2._0 - k * magicNum1) - k * magicNum2;
                 var s1$$ = _U.cmp(s1$,
                 0) < 0 ? s1$ + magicNum6 : s1$;
                 var z = s1$$ - s2$$;
                 var z$ = _U.cmp(z,
                 1) < 0 ? z + magicNum8 : z;
                 return {ctor: "_Tuple2"
                        ,_0: z$
                        ,_1: A2(Standard,s1$$,s2$$)};
              }();}
         _E.Case($moduleName,
         "between lines 58 and 66");
      }();
   };
   var stdSplit = function (_v6) {
      return function () {
         switch (_v6.ctor)
         {case "Standard":
            return function () {
                 var _raw = Basics.snd(stdNext(_v6)),
                 $ = _raw.ctor === "Standard" ? _raw : _E.Case($moduleName,
                 "on line 72, column 28 to 44"),
                 t1 = $._0,
                 t2 = $._1;
                 var new_s2 = _U.eq(_v6._1,
                 1) ? magicNum7 - 1 : _v6._1 - 1;
                 var new_s1 = _U.eq(_v6._0,
                 magicNum6 - 1) ? 1 : _v6._0 + 1;
                 return {ctor: "_Tuple2"
                        ,_0: A2(Standard,new_s1,t2)
                        ,_1: A2(Standard,t1,new_s2)};
              }();}
         _E.Case($moduleName,
         "between lines 70 and 73");
      }();
   };
   var generator = function (seed) {
      return A4(Generator.Generator,
      mkStdGen(seed),
      stdNext,
      stdSplit,
      stdRange);
   };
   _elm.Generator.Standard.values = {_op: _op
                                    ,generator: generator};
   return _elm.Generator.Standard.values;
};Elm.Generator = Elm.Generator || {};
Elm.Generator.make = function (_elm) {
   "use strict";
   _elm.Generator = _elm.Generator || {};
   if (_elm.Generator.values)
   return _elm.Generator.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Generator";
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
   var Generator = F4(function (a,
   b,
   c,
   d) {
      return {_: {}
             ,next: b
             ,range: d
             ,split: c
             ,state: a};
   });
   var listOfHelp = F4(function (list,
   generate,
   n,
   generator) {
      return _U.cmp(n,
      1) < 0 ? {ctor: "_Tuple2"
               ,_0: List.reverse(list)
               ,_1: generator} : function () {
         var $ = generate(generator),
         value = $._0,
         generator$ = $._1;
         return A4(listOfHelp,
         {ctor: "::",_0: value,_1: list},
         generate,
         n - 1,
         generator$);
      }();
   });
   var listOf = listOfHelp(_L.fromArray([]));
   var minInt32 = -2147483648;
   var maxInt32 = 2147483647;
   var iLogBase = F2(function (b,
   i) {
      return _U.cmp(i,
      b) < 0 ? 1 : 1 + A2(iLogBase,
      b,
      i / b | 0);
   });
   var int32Range = F2(function (_v0,
   generator) {
      return function () {
         switch (_v0.ctor)
         {case "_Tuple2":
            return _U.cmp(_v0._0,
              _v0._1) > 0 ? A2(int32Range,
              {ctor: "_Tuple2"
              ,_0: _v0._1
              ,_1: _v0._0},
              generator) : function () {
                 var b = 2147483561;
                 var f = F3(function (n,
                 acc,
                 state) {
                    return function () {
                       switch (n)
                       {case 0: return {ctor: "_Tuple2"
                                       ,_0: acc
                                       ,_1: state};}
                       return function () {
                          var $ = generator.next(state),
                          x = $._0,
                          state$ = $._1;
                          return A3(f,
                          n - 1,
                          x + acc * b,
                          state$);
                       }();
                    }();
                 });
                 var k = _v0._1 - _v0._0 + 1;
                 var n = A2(iLogBase,b,k);
                 var $ = A3(f,
                 n,
                 1,
                 generator.state),
                 v = $._0,
                 state$ = $._1;
                 return {ctor: "_Tuple2"
                        ,_0: _v0._0 + A2(Basics.mod,v,k)
                        ,_1: _U.replace([["state"
                                         ,state$]],
                        generator)};
              }();}
         _E.Case($moduleName,
         "between lines 73 and 86");
      }();
   });
   var floatRange = F2(function (_v5,
   generator) {
      return function () {
         switch (_v5.ctor)
         {case "_Tuple2":
            return _U.cmp(_v5._0,
              _v5._1) > 0 ? A2(floatRange,
              {ctor: "_Tuple2"
              ,_0: _v5._1
              ,_1: _v5._0},
              generator) : function () {
                 var $ = A2(int32Range,
                 {ctor: "_Tuple2"
                 ,_0: minInt32
                 ,_1: maxInt32},
                 generator),
                 x = $._0,
                 generator$ = $._1;
                 var scaled = (_v5._0 + _v5._1) / 2 + (_v5._1 - _v5._0) / Basics.toFloat(maxInt32 - minInt32) * Basics.toFloat(x);
                 return {ctor: "_Tuple2"
                        ,_0: scaled
                        ,_1: generator$};
              }();}
         _E.Case($moduleName,
         "between lines 117 and 122");
      }();
   });
   var $float = floatRange({ctor: "_Tuple2"
                           ,_0: 0
                           ,_1: 1});
   var int32 = int32Range({ctor: "_Tuple2"
                          ,_0: minInt32
                          ,_1: maxInt32});
   _elm.Generator.values = {_op: _op
                           ,Generator: Generator
                           ,int32: int32
                           ,int32Range: int32Range
                           ,$float: $float
                           ,floatRange: floatRange
                           ,listOf: listOf
                           ,minInt32: minInt32
                           ,maxInt32: maxInt32};
   return _elm.Generator.values;
};Elm.Playground = Elm.Playground || {};
Elm.Playground.make = function (_elm) {
   "use strict";
   _elm.Playground = _elm.Playground || {};
   if (_elm.Playground.values)
   return _elm.Playground.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Playground";
   var Basics = Elm.Basics.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var Internal = Elm.Internal.make(_elm);
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
   var Window = Elm.Window.make(_elm);
   var _op = {};
   var playWithRate = F2(function (rate,
   playground) {
      return function () {
         var input = A2(Signal._op["~"],
         A2(Signal._op["<~"],
         F2(function (v0,v1) {
            return {ctor: "_Tuple2"
                   ,_0: v0
                   ,_1: v1};
         }),
         Internal.realworld),
         Internal.inputs(rate));
         var update = Internal.updater(playground.update);
         return A2(Signal._op["~"],
         A2(Signal._op["<~"],
         Basics.uncurry(Graphics.Collage.collage),
         Window.dimensions),
         A2(Signal._op["<~"],
         playground.render,
         A3(Signal.foldp,
         update,
         playground.initialState,
         input)));
      }();
   });
   var play = playWithRate(60);
   var Playground = F3(function (a,
   b,
   c) {
      return {_: {}
             ,initialState: b
             ,render: a
             ,update: c};
   });
   _elm.Playground.values = {_op: _op
                            ,play: play
                            ,playWithRate: playWithRate
                            ,Playground: Playground};
   return _elm.Playground.values;
};Elm.Internal = Elm.Internal || {};
Elm.Internal.make = function (_elm) {
   "use strict";
   _elm.Internal = _elm.Internal || {};
   if (_elm.Internal.values)
   return _elm.Internal.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Internal";
   var Basics = Elm.Basics.make(_elm);
   var Char = Elm.Char.make(_elm);
   var Color = Elm.Color.make(_elm);
   var Dict = Elm.Dict.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Collage = Elm.Graphics.Collage.make(_elm);
   var Graphics = Graphics || {};
   Graphics.Element = Elm.Graphics.Element.make(_elm);
   var Keyboard = Elm.Keyboard.make(_elm);
   var Keyboard = Keyboard || {};
   Keyboard.Keys = Elm.Keyboard.Keys.make(_elm);
   var List = Elm.List.make(_elm);
   var Maybe = Elm.Maybe.make(_elm);
   var Mouse = Elm.Mouse.make(_elm);
   var Native = Native || {};
   Native.Json = Elm.Native.Json.make(_elm);
   var Native = Native || {};
   Native.Ports = Elm.Native.Ports.make(_elm);
   var Playground = Playground || {};
   Playground.Input = Elm.Playground.Input.make(_elm);
   var Set = Elm.Set.make(_elm);
   var Signal = Elm.Signal.make(_elm);
   var String = Elm.String.make(_elm);
   var Text = Elm.Text.make(_elm);
   var Time = Elm.Time.make(_elm);
   var Window = Elm.Window.make(_elm);
   var _op = {};
   var specialKeys = Dict.fromList(_L.fromArray([{ctor: "_Tuple2"
                                                 ,_0: 17
                                                 ,_1: Keyboard.Keys.ctrl}
                                                ,{ctor: "_Tuple2"
                                                 ,_0: 16
                                                 ,_1: Keyboard.Keys.shift}
                                                ,{ctor: "_Tuple2"
                                                 ,_0: 32
                                                 ,_1: Keyboard.Keys.space}
                                                ,{ctor: "_Tuple2"
                                                 ,_0: 13
                                                 ,_1: Keyboard.Keys.enter}]));
   var alphas$$ = _L.fromArray([Keyboard.Keys.a
                               ,Keyboard.Keys.b
                               ,Keyboard.Keys.c
                               ,Keyboard.Keys.d
                               ,Keyboard.Keys.e
                               ,Keyboard.Keys.f
                               ,Keyboard.Keys.g
                               ,Keyboard.Keys.h
                               ,Keyboard.Keys.i
                               ,Keyboard.Keys.j
                               ,Keyboard.Keys.k
                               ,Keyboard.Keys.l
                               ,Keyboard.Keys.m
                               ,Keyboard.Keys.n
                               ,Keyboard.Keys.o
                               ,Keyboard.Keys.p
                               ,Keyboard.Keys.q
                               ,Keyboard.Keys.r
                               ,Keyboard.Keys.s
                               ,Keyboard.Keys.t
                               ,Keyboard.Keys.u
                               ,Keyboard.Keys.v
                               ,Keyboard.Keys.w
                               ,Keyboard.Keys.x
                               ,Keyboard.Keys.y
                               ,Keyboard.Keys.z]);
   var alphas$ = A2(List.map,
   Char.toCode,
   _L.fromArray([_U.chr("a")
                ,_U.chr("b")
                ,_U.chr("c")
                ,_U.chr("d")
                ,_U.chr("e")
                ,_U.chr("f")
                ,_U.chr("g")
                ,_U.chr("h")
                ,_U.chr("i")
                ,_U.chr("j")
                ,_U.chr("k")
                ,_U.chr("l")
                ,_U.chr("m")
                ,_U.chr("n")
                ,_U.chr("o")
                ,_U.chr("p")
                ,_U.chr("q")
                ,_U.chr("r")
                ,_U.chr("s")
                ,_U.chr("t")
                ,_U.chr("u")
                ,_U.chr("v")
                ,_U.chr("w")
                ,_U.chr("x")
                ,_U.chr("y")
                ,_U.chr("z")]));
   var alphaKeys = Dict.fromList(A2(List.zip,
   alphas$,
   alphas$$));
   var arrowKeys = Dict.fromList(_L.fromArray([{ctor: "_Tuple2"
                                               ,_0: 37
                                               ,_1: Keyboard.Keys.arrowLeft}
                                              ,{ctor: "_Tuple2"
                                               ,_0: 38
                                               ,_1: Keyboard.Keys.arrowUp}
                                              ,{ctor: "_Tuple2"
                                               ,_0: 39
                                               ,_1: Keyboard.Keys.arrowRight}
                                              ,{ctor: "_Tuple2"
                                               ,_0: 40
                                               ,_1: Keyboard.Keys.arrowDown}]));
   var numbers$$ = _L.fromArray([Keyboard.Keys.zero
                                ,Keyboard.Keys.one
                                ,Keyboard.Keys.two
                                ,Keyboard.Keys.three
                                ,Keyboard.Keys.four
                                ,Keyboard.Keys.five
                                ,Keyboard.Keys.six
                                ,Keyboard.Keys.seven
                                ,Keyboard.Keys.eight
                                ,Keyboard.Keys.nine]);
   var numbers$ = A2(List.map,
   Char.toCode,
   _L.fromArray([_U.chr("0")
                ,_U.chr("1")
                ,_U.chr("2")
                ,_U.chr("3")
                ,_U.chr("4")
                ,_U.chr("5")
                ,_U.chr("6")
                ,_U.chr("7")
                ,_U.chr("8")
                ,_U.chr("9")]));
   var numbers = Dict.fromList(A2(List.zip,
   numbers$,
   numbers$$));
   var keys = A3(List.foldr,
   Dict.union,
   Dict.empty,
   _L.fromArray([alphaKeys
                ,specialKeys
                ,arrowKeys
                ,numbers]));
   var toKey = function (code) {
      return A2(Dict.get,
      code,
      keys);
   };
   var toKeys = function ($) {
      return Maybe.justs(List.map(toKey)($));
   };
   var keysDown = A2(Signal._op["<~"],
   function ($) {
      return List.map(Playground.Input.Key)(toKeys($));
   },
   Keyboard.keysDown);
   var lastPressed = function () {
      var match = F2(function (c,
      d) {
         return A2(Set.member,
         c,
         Set.fromList(d));
      });
      var matchSig = A2(Signal._op["~"],
      A2(Signal._op["<~"],
      match,
      Keyboard.lastPressed),
      Signal.merges(_L.fromArray([Keyboard.keysDown
                                 ,A2(Signal.sampleOn,
                                 A2(Time.delay,
                                 1,
                                 Keyboard.keysDown),
                                 Signal.constant(_L.fromArray([])))])));
      return A2(Signal._op["<~"],
      function (c) {
         return List.map(Playground.Input.Tap)(toKeys(_L.fromArray([c])));
      },
      A3(Signal.keepWhen,
      matchSig,
      0,
      Keyboard.lastPressed));
   }();
   var toInputs = F3(function (t,
   click,
   keys) {
      return {ctor: "::"
             ,_0: Playground.Input.Passive(t)
             ,_1: {ctor: "::"
                  ,_0: click
                  ,_1: keys}};
   });
   var withRate = function (rate) {
      return function () {
         var rate$ = Time.fps(rate);
         return A2(Signal._op["~"],
         A2(Signal._op["~"],
         A2(Signal._op["<~"],
         toInputs,
         rate$),
         A2(Signal.sampleOn,
         Mouse.clicks,
         Signal.constant(Playground.Input.MouseDown))),
         keysDown);
      }();
   };
   var singleton = function (x) {
      return _L.fromArray([x]);
   };
   var click = A2(Signal._op["<~"],
   singleton,
   A2(Signal.sampleOn,
   Mouse.clicks,
   Signal.constant(Playground.Input.Click)));
   var inputs = function (rate) {
      return Signal.merges(_L.fromArray([click
                                        ,lastPressed
                                        ,withRate(rate)]));
   };
   var updater = F3(function (update,
   _v0,
   state) {
      return function () {
         switch (_v0.ctor)
         {case "_Tuple2":
            return A3(List.foldl,
              update(_v0._0),
              state,
              _v0._1);}
         _E.Case($moduleName,
         "on line 31, column 33 to 59");
      }();
   });
   var toRealWorld = F2(function (_v4,
   _v5) {
      return function () {
         switch (_v5.ctor)
         {case "_Tuple2":
            return function () {
                 switch (_v4.ctor)
                 {case "_Tuple2":
                    return function () {
                         var right = Basics.toFloat(_v4._0) / 2;
                         var left = 0 - right;
                         var mouseX = Basics.toFloat(_v5._0) + left;
                         var top = Basics.toFloat(_v4._1) / 2;
                         var bottom = 0 - top;
                         var mouseY = top - Basics.toFloat(_v5._1);
                         return {_: {}
                                ,bottom: bottom
                                ,left: left
                                ,mouse: {_: {}
                                        ,x: mouseX
                                        ,y: mouseY}
                                ,right: right
                                ,top: top};
                      }();}
                 _E.Case($moduleName,
                 "between lines 15 and 25");
              }();}
         _E.Case($moduleName,
         "between lines 15 and 25");
      }();
   });
   var realworld = A2(Signal._op["~"],
   A2(Signal._op["<~"],
   toRealWorld,
   Window.dimensions),
   Mouse.position);
   _elm.Internal.values = {_op: _op
                          ,toRealWorld: toRealWorld
                          ,realworld: realworld
                          ,updater: updater
                          ,inputs: inputs
                          ,singleton: singleton
                          ,click: click
                          ,toInputs: toInputs
                          ,withRate: withRate
                          ,lastPressed: lastPressed
                          ,keysDown: keysDown
                          ,keys: keys
                          ,numbers: numbers
                          ,numbers$: numbers$
                          ,numbers$$: numbers$$
                          ,arrowKeys: arrowKeys
                          ,alphaKeys: alphaKeys
                          ,alphas$: alphas$
                          ,alphas$$: alphas$$
                          ,specialKeys: specialKeys
                          ,toKeys: toKeys
                          ,toKey: toKey};
   return _elm.Internal.values;
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
   var equal = F2(function (k0,
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
                               ,equal: equal
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
Elm.Main = Elm.Main || {};
Elm.Main.make = function (_elm) {
   "use strict";
   _elm.Main = _elm.Main || {};
   if (_elm.Main.values)
   return _elm.Main.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Main";
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
   var delta = Time.fps(60);
   var rotateShip = F2(function (g,
   r) {
      return function () {
         var newAngle = g.angle + r;
         return _U.cmp(newAngle,
         2 * Basics.pi) > 0 ? _U.replace([["angle"
                                          ,newAngle - 2 * Basics.pi]],
         g) : _U.cmp(newAngle,
         0) < 0 ? _U.replace([["angle"
                              ,newAngle + 2 * Basics.pi]],
         g) : _U.replace([["angle"
                          ,newAngle]],
         g);
      }();
   });
   var NoInput = {ctor: "NoInput"};
   var Shoot = {ctor: "Shoot"};
   var RotCW = {ctor: "RotCW"};
   var RotCCW = {ctor: "RotCCW"};
   var Backward = {ctor: "Backward"};
   var Forward = {ctor: "Forward"};
   var input = function (_v0) {
      return function () {
         switch (_v0.ctor)
         {case "_Tuple2":
            return _U.eq(_v0._0.x,
              -1) ? RotCCW : _U.eq(_v0._0.x,
              1) ? RotCW : _U.eq(_v0._0.y,
              -1) ? Backward : _U.eq(_v0._0.y,
              1) ? Forward : _v0._1 ? Shoot : NoInput;}
         _E.Case($moduleName,
         "between lines 66 and 71");
      }();
   };
   var initalBulletState = {_: {}
                           ,angle: Basics.pi / 2
                           ,birthTime: 0
                           ,shot: false
                           ,vx: 0
                           ,vy: 0
                           ,x: 0
                           ,y: 0};
   var update = F2(function (_v4,
   g) {
      return function () {
         switch (_v4.ctor)
         {case "_Tuple2":
            return function () {
                 var resetBullet = _U.replace([["x"
                                               ,g.x]
                                              ,["y",g.y]
                                              ,["vx",g.vx]
                                              ,["vy",g.vy]],
                 initalBulletState);
                 var tempBullet = g.bullet;
                 var bShot = _U.replace([["x"
                                         ,tempBullet.vx + tempBullet.x]
                                        ,["y"
                                         ,tempBullet.vy + tempBullet.y]],
                 tempBullet);
                 var b = _U.replace([["x",g.x]
                                    ,["y",g.y]
                                    ,["vx",g.vx]
                                    ,["vy",g.vy]],
                 tempBullet);
                 var b$ = _U.replace([["shot"
                                      ,true]
                                     ,["birthTime",g.time]
                                     ,["x",g.x]
                                     ,["y",g.y]
                                     ,["vx",g.vx + 17]
                                     ,["vy",g.vy - 13]
                                     ,["angle",g.angle]],
                 b);
                 var g$ = _U.replace([["time"
                                      ,g.time + _v4._1]
                                     ,["shoot",false]
                                     ,["bullet",b]],
                 g);
                 return function () {
                    switch (_v4._0.ctor)
                    {case "Backward":
                       return _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? _U.replace([["shoot"
                                                 ,false]
                                                ,["bullet",resetBullet]
                                                ,["y",g.y + 1]],
                         g$) : _U.eq(b.shot,
                         true) ? _U.replace([["bullet"
                                             ,bShot]
                                            ,["y",g.y + 1]],
                         g$) : _U.replace([["y"
                                           ,g.y + 1]],
                         g$);
                       case "Forward":
                       return _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? _U.replace([["shoot"
                                                 ,false]
                                                ,["bullet",resetBullet]
                                                ,["x",g.x + 1]],
                         g$) : _U.eq(b.shot,
                         true) ? _U.replace([["bullet"
                                             ,bShot]
                                            ,["x",g.x + 1]],
                         g$) : _U.replace([["x"
                                           ,g.x + 1]],
                         g$);
                       case "NoInput":
                       return _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? _U.replace([["shoot"
                                                 ,false]
                                                ,["bullet",resetBullet]],
                         g$) : _U.eq(b.shot,
                         true) ? _U.replace([["bullet"
                                             ,bShot]],
                         g$) : _U.replace([["bullet",b]],
                         g$);
                       case "RotCCW":
                       return _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? A2(rotateShip,
                         _U.replace([["shoot",false]
                                    ,["bullet",resetBullet]],
                         g$),
                         Basics.pi / 60) : _U.eq(b.shot,
                         true) ? A2(rotateShip,
                         _U.replace([["bullet",bShot]],
                         g$),
                         Basics.pi / 60) : A2(rotateShip,
                         g$,
                         Basics.pi / 60);
                       case "RotCW":
                       return _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? A2(rotateShip,
                         _U.replace([["shoot",false]
                                    ,["bullet",resetBullet]],
                         g$),
                         (0 - Basics.pi) / 60) : _U.eq(b.shot,
                         true) ? A2(rotateShip,
                         _U.replace([["bullet",bShot]],
                         g$),
                         (0 - Basics.pi) / 60) : A2(rotateShip,
                         g$,
                         (0 - Basics.pi) / 60);
                       case "Shoot":
                       return _U.eq(b.shot,
                         false) ? _U.replace([["shoot"
                                              ,true]
                                             ,["bullet",b$]],
                         g$) : _U.eq(b.shot,
                         true) && _U.cmp(g.time - b.birthTime,
                         2000) > 0 ? _U.replace([["shoot"
                                                 ,false]
                                                ,["bullet",resetBullet]],
                         g$) : _U.replace([["shoot",true]
                                          ,["bullet",bShot]],
                         g$);}
                    _E.Case($moduleName,
                    "between lines 37 and 56");
                 }();
              }();}
         _E.Case($moduleName,
         "between lines 30 and 56");
      }();
   });
   var BulletState = F7(function (a,
   b,
   c,
   d,
   e,
   f,
   g) {
      return {_: {}
             ,angle: e
             ,birthTime: f
             ,shot: g
             ,vx: c
             ,vy: d
             ,x: a
             ,y: b};
   });
   var initalGameState = {_: {}
                         ,angle: Basics.pi / 2
                         ,bullet: initalBulletState
                         ,shoot: false
                         ,time: 0
                         ,vx: 0
                         ,vy: 0
                         ,x: 0
                         ,y: 0};
   var stateSignal = A3(Signal.foldp,
   update,
   initalGameState,
   A2(Signal._op["~"],
   A2(Signal._op["<~"],
   F2(function (v0,v1) {
      return {ctor: "_Tuple2"
             ,_0: v0
             ,_1: v1};
   }),
   A2(Signal._op["<~"],
   input,
   A2(Signal._op["~"],
   A2(Signal._op["<~"],
   F2(function (v0,v1) {
      return {ctor: "_Tuple2"
             ,_0: v0
             ,_1: v1};
   }),
   A2(Signal.sampleOn,
   delta,
   Keyboard.arrows)),
   A2(Signal.sampleOn,
   delta,
   Keyboard.space)))),
   delta));
   var main = A2(Signal._op["<~"],
   Text.asText,
   stateSignal);
   var GameState = F8(function (a,
   b,
   c,
   d,
   e,
   f,
   g,
   h) {
      return {_: {}
             ,angle: e
             ,bullet: h
             ,shoot: g
             ,time: f
             ,vx: c
             ,vy: d
             ,x: a
             ,y: b};
   });
   _elm.Main.values = {_op: _op
                      ,initalGameState: initalGameState
                      ,initalBulletState: initalBulletState
                      ,rotateShip: rotateShip
                      ,update: update
                      ,delta: delta
                      ,stateSignal: stateSignal
                      ,input: input
                      ,main: main
                      ,Forward: Forward
                      ,Backward: Backward
                      ,RotCCW: RotCCW
                      ,RotCW: RotCW
                      ,Shoot: Shoot
                      ,NoInput: NoInput
                      ,GameState: GameState
                      ,BulletState: BulletState};
   return _elm.Main.values;
};
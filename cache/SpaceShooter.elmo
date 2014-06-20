Elm.SpaceShooter = Elm.SpaceShooter || {};
Elm.SpaceShooter.make = function (_elm) {
   "use strict";
   _elm.SpaceShooter = _elm.SpaceShooter || {};
   if (_elm.SpaceShooter.values)
   return _elm.SpaceShooter.values;
   var _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "SpaceShooter";
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
   var render = function (state) {
      return function () {
         var form = Graphics.Collage.move({ctor: "_Tuple2"
                                          ,_0: state.x
                                          ,_1: state.y})(Graphics.Collage.rotate(state.angle)(A2(Graphics.Collage.filled,
         Color.blue,
         A2(Graphics.Collage.ngon,
         3,
         20))));
         var display = A3(Graphics.Collage.collage,
         500,
         500,
         _L.fromArray([form]));
         var debug = Text.asText(state);
         return A2(Graphics.Element.flow,
         Graphics.Element.down,
         _L.fromArray([display,debug]));
      }();
   };
   var spaceBar = 32;
   var downArrow = 40;
   var upArrow = 38;
   var rightArrow = 39;
   var leftArrow = 37;
   var delta = Time.fps(60);
   var member = F2(function (inputs,
   toCheck) {
      return A2(List.any,
      function (c) {
         return _U.eq(toCheck,c);
      },
      inputs);
   });
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
   var update = F2(function (i,g) {
      return function () {
         var b$ = {_: {}
                  ,angle: g.angle
                  ,birthTime: g.time
                  ,shot: true
                  ,vx: g.vx + 17
                  ,vy: g.vy - 13
                  ,x: g.x
                  ,y: g.y};
         var tempBullet = g.bullet;
         var b = _U.replace([["x",g.x]
                            ,["y",g.y]
                            ,["vx",g.vx]
                            ,["vy",g.vy]],
         tempBullet);
         return function () {
            switch (i.ctor)
            {case "Backward":
               return _U.replace([["vx"
                                  ,g.acc * -1 * Basics.cos(g.angle)]
                                 ,["vy"
                                  ,g.acc * -1 * Basics.sin(g.angle)]
                                 ,["acc"
                                  ,A2(member,
                                  g.prevInput,
                                  Backward) && _U.cmp(g.acc,
                                  3) < 0 ? g.acc + 0.2 : 0]],
                 g);
               case "Forward":
               return _U.replace([["vx"
                                  ,g.acc * Basics.cos(g.angle)]
                                 ,["vy"
                                  ,g.acc * Basics.sin(g.angle)]
                                 ,["acc"
                                  ,A2(member,
                                  g.prevInput,
                                  Forward) && _U.cmp(g.acc,
                                  3) < 0 ? g.acc + 0.2 : 0]],
                 g);
               case "NoInput": return g;
               case "RotCCW":
               return A2(rotateShip,
                 g,
                 Basics.pi / 60);
               case "RotCW":
               return A2(rotateShip,
                 g,
                 (0 - Basics.pi) / 60);
               case "Shoot":
               return _U.eq(b.shot,
                 false) ? _U.replace([["shoot"
                                      ,true]
                                     ,["bullet",b$]],
                 g) : g;}
            _E.Case($moduleName,
            "between lines 114 and 129");
         }();
      }();
   });
   var updateHelper = F2(function (inputs,
   state) {
      return List.isEmpty(inputs) ? state : function () {
         var rest = List.tail(inputs);
         var first = List.head(inputs);
         var state$ = A2(update,
         first,
         state);
         return A2(updateHelper,
         rest,
         state$);
      }();
   });
   var input = function (keycode) {
      return _U.eq(keycode,
      leftArrow) ? RotCCW : _U.eq(keycode,
      rightArrow) ? RotCW : _U.eq(keycode,
      downArrow) ? Backward : _U.eq(keycode,
      upArrow) ? Forward : _U.eq(keycode,
      spaceBar) ? Shoot : NoInput;
   };
   var input$ = function (codes) {
      return A2(List.map,
      input,
      codes);
   };
   var initalBulletState = {_: {}
                           ,angle: Basics.pi / 2
                           ,birthTime: 0
                           ,shot: false
                           ,vx: 0
                           ,vy: 0
                           ,x: 0
                           ,y: 0};
   var physics = F3(function (t,
   inputs,
   g) {
      return function () {
         var resetBullet = _U.replace([["x"
                                       ,g.x]
                                      ,["y",g.y]
                                      ,["vx",g.vx]
                                      ,["vy",g.vy]],
         initalBulletState);
         var tempBullet = g.bullet;
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
                              ,g.time + t]
                             ,["x",g.x + g.vx]
                             ,["y",g.y + g.vy]
                             ,["prevInput",inputs]
                             ,["acc"
                              ,A2(member,
                              inputs,
                              Forward) || A2(member,
                              inputs,
                              Backward) ? g.acc : 0]
                             ,["bullet",b]],
         g);
         var bShot = _U.replace([["x"
                                 ,tempBullet.vx + tempBullet.x]
                                ,["y"
                                 ,tempBullet.vy + tempBullet.y]],
         tempBullet);
         return _U.eq(b.shot,
         true) && _U.cmp(g.time - b.birthTime,
         2000) > 0 ? _U.replace([["shoot"
                                 ,false]
                                ,["bullet",resetBullet]],
         g$) : _U.eq(b.shot,
         true) ? _U.replace([["bullet"
                             ,bShot]],
         g$) : g$;
      }();
   });
   var update$ = F2(function (_v1,
   g) {
      return function () {
         switch (_v1.ctor)
         {case "_Tuple2":
            return function () {
                 var g$ = A3(physics,
                 _v1._1,
                 _v1._0,
                 g);
                 return A2(updateHelper,
                 _v1._0,
                 g$);
              }();}
         _E.Case($moduleName,
         "between lines 94 and 95");
      }();
   });
   var initalGameState = {_: {}
                         ,acc: 1
                         ,angle: Basics.pi / 2
                         ,bullet: initalBulletState
                         ,prevInput: _L.fromArray([])
                         ,shoot: false
                         ,time: 0
                         ,vx: 0
                         ,vy: 0
                         ,x: 0
                         ,y: 0};
   var stateSignal = A3(Signal.foldp,
   update$,
   initalGameState,
   A2(Signal._op["~"],
   A2(Signal._op["<~"],
   F2(function (v0,v1) {
      return {ctor: "_Tuple2"
             ,_0: v0
             ,_1: v1};
   }),
   A2(Signal._op["<~"],
   input$,
   Keyboard.keysDown)),
   delta));
   var main = A2(Signal._op["<~"],
   render,
   stateSignal);
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
   var GameState = function (a) {
      return function (b) {
         return function (c) {
            return function (d) {
               return function (e) {
                  return function (f) {
                     return function (g) {
                        return function (h) {
                           return function (i) {
                              return function (j) {
                                 return {_: {}
                                        ,acc: j
                                        ,angle: e
                                        ,bullet: h
                                        ,prevInput: i
                                        ,shoot: g
                                        ,time: f
                                        ,vx: c
                                        ,vy: d
                                        ,x: a
                                        ,y: b};
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
   _elm.SpaceShooter.values = {_op: _op
                              ,initalGameState: initalGameState
                              ,initalBulletState: initalBulletState
                              ,rotateShip: rotateShip
                              ,member: member
                              ,physics: physics
                              ,update$: update$
                              ,updateHelper: updateHelper
                              ,update: update
                              ,delta: delta
                              ,stateSignal: stateSignal
                              ,leftArrow: leftArrow
                              ,rightArrow: rightArrow
                              ,upArrow: upArrow
                              ,downArrow: downArrow
                              ,spaceBar: spaceBar
                              ,input$: input$
                              ,input: input
                              ,render: render
                              ,main: main
                              ,Forward: Forward
                              ,Backward: Backward
                              ,RotCCW: RotCCW
                              ,RotCW: RotCW
                              ,Shoot: Shoot
                              ,NoInput: NoInput
                              ,GameState: GameState
                              ,BulletState: BulletState};
   return _elm.SpaceShooter.values;
};
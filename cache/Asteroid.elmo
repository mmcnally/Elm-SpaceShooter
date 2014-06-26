Elm.Asteroid = Elm.Asteroid || {};
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
};
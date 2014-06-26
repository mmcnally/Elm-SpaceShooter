Elm.Bullet = Elm.Bullet || {};
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
};
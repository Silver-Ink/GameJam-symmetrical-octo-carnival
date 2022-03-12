return function (game, arg)
  local p1 = game.create(require("element.stickmanInit"), {x=arg.x or 3, y=arg.y or 3})
  p1.mid = arg.mid or -1
end
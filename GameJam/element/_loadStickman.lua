return function (game, arg)
  local p1 = game.create(require("element.stickmanInit"), {x=arg.x or 3, y=arg.y or 3})
  if(p1 ~= nil) then
    p1.mid = arg.mid or -1
  end
end
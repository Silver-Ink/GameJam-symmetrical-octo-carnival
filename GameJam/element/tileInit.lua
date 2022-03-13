return function (elem, arg)
  local rect = require("../rectangle")
  local sprite = require("../sprite")

  elem.draw = require("element.logic.tileDraw")
  elem.hitbox = rect.create(arg.x or 1, arg.y or 1, arg.hx or 1, arg.hy or 1)
  elem.sprite = sprite.create("Content/"..(arg.name))
  elem.isSolid = arg.isSolid
  elem.type = arg.type or "other"
  if(elem.isSolid == nil) then
    elem.isSolid = true
  end
end
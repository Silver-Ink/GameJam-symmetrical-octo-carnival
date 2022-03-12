return function (elem, arg)
  local rect = require("../rectangle")
  local sprite = require("../sprite")

  elem.draw = require("element.tileDraw")
  elem.hitbox = rect.create(arg.x, arg.y, 1, 1)
  elem.sprite = sprite.create("Content/"..(arg.name))
end
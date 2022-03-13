return function (elem, arg)
  local rect = require("../rectangle")
  local sprite = require("../sprite")

  elem.draw = require("element.logic.tileDraw")
  elem.hitbox = rect.create(arg.x or 1, arg.y or 1, 1, 1)
  elem.sprite = sprite.create("Content/"..(arg.name))
end
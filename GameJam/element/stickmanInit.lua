return function (elem, arg)
  local rect = require("../rectangle")
  local sprite = require("../sprite")

  elem.draw = require("element.elementDraw")
  elem.update = require("element.stickmanUpdate")
  elem.hitbox = rect.create(arg.x or 0, arg.y or 0, 1, 1)
  elem.sprite = sprite.create("Content/stickman.png")
end
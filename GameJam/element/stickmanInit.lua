function AddKey(e, pos)
  local k = Game.create(require("element.tileInit"), {name="key.png", x=0, y=0, isSolid=false, type = "key"}, require("element.logic.keyUpdate"))
  if(k ~= nil) then
    if #e.inventory == 0 then
      k.ownerIndex = e.index
    else
      k.ownerIndex = e.inventory[#e.inventory].index
    end
    table.insert(e.inventory, k)
  end
end


--Init player
return function (elem, arg)
  local rect = require("../rectangle")
  local sprite = require("../sprite")

  elem.draw = require("element.logic.stickmanDraw")
  elem.update = require("element.logic.stickmanUpdate")
  elem.hitbox = rect.create(arg.x or 0, arg.y or 0, 1, 1)
  elem.sprite = sprite.create("Content/as.png")
  elem.type = "player"
  elem.inventory = {}
  AddKey(elem)
  AddKey(elem)
  
end
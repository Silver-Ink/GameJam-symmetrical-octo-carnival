function Distance ( x1, y1, x2, y2)
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

return function (elem)
  if(TICK % 10 == 0) then
    for i = 1, Game.MAX_ELEMENT do
      local e = Game.elements[i]
      if(e.isUsed and e.type == "player" and Distance(e.hitbox.x+e.hitbox.w/2, e.hitbox.y+e.hitbox.h/2, elem.hitbox.x+elem.hitbox.w/2, elem.hitbox.y+elem.hitbox.h/2) <= 2) then
        print("Chest open")
        local t = string.sub(elem.sprite.path, 0, #elem.sprite.path-9).."open.png"
        print(t)
        elem.sprite = require("sprite").create(t)
        elem.update = nil

        local k = Game.create(require("element.tileInit"), {name="key.png", x=elem.hitbox.x+elem.hitbox.w/4, y=elem.hitbox.y+elem.hitbox.h/4, isSolid=false, type = "key"}, require("element.logic.keyUpdate"))
        if(k ~= nil) then
          if #e.inventory == 0 then
            k.ownerIndex = e.index
          else
            k.ownerIndex = e.inventory[#e.inventory].index
          end
          table.insert(e.inventory, k)
        end
      end
    end
  end
end
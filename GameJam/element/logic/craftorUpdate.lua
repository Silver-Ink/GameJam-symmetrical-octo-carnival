return function(elem)
  local e
  for i = 1, Game.MAX_ELEMENT, 1 do
    e = Game.elements[i]
    if e.isUsed and e.type == "player" 
    and Distance(e.hitbox.x+e.hitbox.w/2, e.hitbox.y+e.hitbox.h/2, elem.hitbox.x+elem.hitbox.w/2, elem.hitbox.y+elem.hitbox.h/2) <= 1 then
      break
    end
  end
  
  if love.keyboard.isDown("space") then
    
    print("crafting")
    local count = 0
    for i = 1, #e.inventory do
      local item = e.inventory[i]
      if item.type == "key" then
        count = count + 1
      end
    end

    if (count >= 2) then
      for i = 1, #e.inventory do
        local item = e.inventory[i]
        if (item.type == "key" and count > 0) then
          table.remove(e.inventory, i)
          i = i - 1
          
        end
      end
    end
    local superkey = Game.create(require("element.tileInit"), {name="key++.png", x=e.hitbox.x+e.hitbox.w/4, y=e.hitbox.y+e.hitbox.h/4, isSolid=false, type = "superKey"}, require("element.logic.keyUpdate"))
    if(superkey ~= nil) then
      if #e.inventory == 0 then
        superkey.ownerIndex = e.index
      else
        superkey.ownerIndex = e.inventory[#e.inventory].index
      end
      table.insert(e.inventory, superkey)
    end

  end
end
return function (elem)
  if(elem.tempsDessus == nil) then
    elem.tempsDessus = 0
  end


  if(TICK % 10 == 0) then
    for i = 1, Game.MAX_ELEMENT do
      local e = Game.elements[i]
      if(e.isUsed and e.type == "player" and Distance(e.hitbox.x+e.hitbox.w/2, e.hitbox.y+e.hitbox.h/2, elem.hitbox.x+elem.hitbox.w/2, elem.hitbox.y+elem.hitbox.h/2) <= 3) then
        elem.tempsDessus = elem.tempsDessus+1
        --print("trap opening..."..elem.tempsDessus)
        if(elem.tempsDessus >= 6*2) then
          elem.update = nil
          elem.sprite = require("sprite").create("Content/trape_open.png")
        end
        
        return
      end
    end

    elem.tempsDessus = 0
  end
end
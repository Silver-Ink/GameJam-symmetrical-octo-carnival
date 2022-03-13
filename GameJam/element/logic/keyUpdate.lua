return function (elem)
  
  local e = Game.elements[elem.ownerIndex]
  if(e ~= nil) then

    local c = 0.95
    elem.hitbox.x = elem.hitbox.x*c+e.hitbox.x*(1-c)
    elem.hitbox.y = elem.hitbox.y*c+(e.hitbox.y-0.2)*(1-c)
    
    if(TICK % 10 == 0) then

    end
  end

end
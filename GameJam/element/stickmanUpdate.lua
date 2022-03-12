return function (elem)

  print("mid"..elem.mid)
  print("MID"..MID)

  if(elem.mid == MID) then
    local camSpeed =  1/16
    if love.keyboard.isDown("right") then
      elem.hitbox.x = elem.hitbox.x + camSpeed
    end
    if love.keyboard.isDown("left") then
      elem.hitbox.x = elem.hitbox.x - camSpeed
    end
  
    if love.keyboard.isDown("up") then
      elem.hitbox.y = elem.hitbox.y - camSpeed
    end
    if love.keyboard.isDown("down") then
      elem.hitbox.y = elem.hitbox.y + camSpeed
    end
  end
end
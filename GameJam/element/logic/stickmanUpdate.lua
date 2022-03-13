return function (elem)

  --print("mid"..elem.mid)
  --print("MID"..MID)
  --(elem.mid or -1)
  if(elem.mid == MID) then
    local xAdd, yAdd = 0, 0
    local max_speed =  1/16
    if love.keyboard.isDown("right") then
      xAdd = 1
      --elem.hitbox.x = elem.hitbox.x + speed
    end
    if love.keyboard.isDown("left") then
      xAdd = -1
    end
  
    if love.keyboard.isDown("up") then
      yAdd = -1
    end
    if love.keyboard.isDown("down") then
      yAdd = 1
    end
    
    elem.hitbox.x = elem.hitbox.x + xAdd*max_speed
    elem.hitbox.y = elem.hitbox.y + yAdd*max_speed

  end
end
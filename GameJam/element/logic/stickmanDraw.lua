return function (elem)
  --love.graphics.rectangle("fill", elem.hitbox.x, elem.hitbox.y, elem.hitbox.w, elem.hitbox.h)
  local img = elem.sprite.image

  local ap = 0.1
  local speed = 5

  
  if(elem.isMoving) then
    speed = speed*2.5
    ap = ap* 2
  end

  local time = (TIME * speed)%6.28318


  local width, height = img:getDimensions( )
  --print(math.abs(math.sin(time) * ap * 2))
  love.graphics.draw(img, elem.hitbox.x + (width/2) / 90, elem.hitbox.y + (height/2)/ 256 - math.abs(math.cos(time) * ap * 2),
   math.sin(time) * ap, 1/width, 1/width,
   width/2, height/2,
     0, math.sin(time) * ap)
end
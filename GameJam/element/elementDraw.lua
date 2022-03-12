return function (elem)
  if(elem.sprite ~= nil) then
    if(elem.sprite.quad == nil) then
      elem.sprite.quad = love.graphics.newQuad(0, 0, elem.sprite.image:getWidth(), elem.sprite.image:getHeight(), elem.sprite.image:getWidth(), elem.sprite.image:getHeight())
    end
    love.graphics.draw(elem.sprite.image, elem.sprite.quad, elem.hitbox.x, elem.hitbox.y, 0, elem.hitbox.w/elem.sprite.image:getWidth(), elem.hitbox.h/elem.sprite.image:getHeight())
    --love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
  end
end
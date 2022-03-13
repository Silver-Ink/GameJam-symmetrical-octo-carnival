
Element = {}

local rect = require("../rectangle")
local color = require("../color")

Element.game_true_create_do_not_use = function (index)
  return { isUsed = false, index = index}
end

Element.hitboxCollide = function(elemA, elemB)
  return elemA.index ~= elemB.index and elemA.hitbox.x+elemA.hitbox.w > elemB.hitbox.x and elemA.hitbox.x < elemB.hitbox.x+elemB.hitbox.w and elemA.hitbox.y+elemA.hitbox.h > elemB.hitbox.y and elemA.hitbox.y < elemB.hitbox.y+elemB.hitbox.h
end

Element.Delete = function (element)
  element.isUsed = false
end

Element.move = function(elem, x, y)
    if(x == 0 and y == 0) then return end
    if(x ~= 0 and y ~= 0) then 
      Element.move(elem, x, 0)
      Element.move(elem, 0, y)
      return
    end

    elem.hitbox.x = elem.hitbox.x+x
    elem.hitbox.y = elem.hitbox.y+y

    for i = 1, Game.MAX_ELEMENT do
      local e = Game.elements[i]
      if(e.isUsed and e.isSolid) then
         if(Element.hitboxCollide(elem, e)) then
          if(x > 0) then
            elem.hitbox.x = e.hitbox.x-elem.hitbox.w
          elseif(x < 0) then
            elem.hitbox.x = e.hitbox.x+e.hitbox.w
          end
          if(y > 0) then
              elem.hitbox.y = e.hitbox.y-elem.hitbox.h
          elseif(y < 0) then
              elem.hitbox.y = e.hitbox.y+e.hitbox.h
          end
           --print("Collide!"..TIME)
         end
      end
    end
end

function Element:reset() 
  for k, v in pairs(self) do
    if(k ~= "index" and k ~= "isUsed") then
      self[k] = nil
    end
  end

  self.hitbox = { hitbox = rect.create(0, 0, 1, 1) }
  self.sprite = nil
  self.update = nil
  self.draw   = nil
  self.type = "tile"
  self.isSolid = true
end

function Element:setMethod(update, draw)
  if(self ~= nil) then
    self.update = update
    self.draw = draw
  end
end

--[[
function element:draw()
  if(self.sprite ~= nil) then
    if(self.sprite.quad == nil) then
      self.sprite.quad = love.graphics.newQuad(0, 0, self.sprite.image:getWidth(), self.sprite.image:getHeight(), self.sprite.image:getWidth(), self.sprite.image:getHeight())
    end
    love.graphics.draw(self.sprite.image, self.sprite.quad, self.hitbox.x, self.hitbox.y, 0, self.hitbox.w/self.sprite.image:getWidth(), self.hitbox.h/self.sprite.image:getHeight())
    --love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
  end
end]]

return Element
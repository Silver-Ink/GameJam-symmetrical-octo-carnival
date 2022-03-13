
Element = {}

local rect = require("../rectangle")
local color = require("../color")

Element.game_true_create_do_not_use = function (index)
  return { isUsed = false, index = index}
end

--function ElementMove(element, game, x, y)
    
--end

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
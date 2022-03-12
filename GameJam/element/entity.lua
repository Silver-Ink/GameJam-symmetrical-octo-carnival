
local entity = {}

local rect = require("../rectangle")
local color = require("../color")

entity.game_true_create_do_not_use = function (index)
  local e = { hitbox = rect.create(0, 0, 1, 1) }
  e.sprite = nil
  e.index = index
  e.isUsed = false
  return e
end

function entity:draw()
  if(self.sprite ~= nil) then
    if(self.sprite.quad == nil) then
      self.sprite.quad = love.graphics.newQuad(0, 0, self.sprite.image:getWidth(), self.sprite.image:getHeight(), self.sprite.image:getWidth(), self.sprite.image:getHeight())
    end
    love.graphics.draw(self.sprite.image, self.sprite.quad, self.hitbox.x, self.hitbox.y, 0, self.hitbox.w/self.sprite.image:getWidth(), self.hitbox.h/self.sprite.image:getHeight())
    --love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
  end
end

return entity

local button = {}

local rect = require("rectangle")
local color = require("color")

button.create = function(rectangle, colorTableWith_R_G_B)
  local b = { hitbox = rectangle, color= colorTableWith_R_G_B or color.white}
  return b
end

function button:draw()
  local scale = 1
  if(button.isPress(self)) then
    scale = 0
  elseif(button.isHover(self)) then
    scale = 0.5
  end 

  color.apply(color.create(self.color.r*scale,self.color.g*scale,self.color.b*scale, self.color.a))
  rect.draw(self.hitbox)
  color.apply(color.white)
end

function button:isHover() -- css vibe
  local h = self.hitbox
  return (MOUSE_X >= h.x and MOUSE_X <= h.x+h.w and MOUSE_Y >= h.y and MOUSE_Y <= h.y+h.h)
end

function button:isPress() 
  return MOUSE_IS_PRESS and MOUSE_WAS_PRESS == false and button.isHover(self)
end

return button
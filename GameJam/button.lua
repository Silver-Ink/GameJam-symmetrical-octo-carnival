
local button = {}

local rect = require("rectangle")
local color = require("color")

button.create = function(rectangle, color, txt)
  color = color or color.white
  local b = { hitbox = rectangle, color= color, colorDisplay = color, txt = txt or "" }
  return b
end

function button:draw()
  if(button.isPress(self)) then
    self.colorDisplay = color.black
  elseif(button.isHover(self)) then
    self.colorDisplay = color.lerp(self.colorDisplay, color.lerp(self.color, color.black, 0.5), 0.9)
  else
    self.colorDisplay = color.lerp(self.colorDisplay, self.color, 0.9)
  end 

  --self.colorDisplay = color.lerp(self.color, )
  color.apply(self.colorDisplay)
  rect.draw(self.hitbox)
  color.apply(color.white)
  love.graphics.print(self.txt, self.hitbox.x+self.hitbox.w/2, self.hitbox.y+self.hitbox.h/2, 0, FONT_BIG, FONT_BIG, self.hitbox.w/2, self.hitbox.h/2)
end

function button:isHover() -- css vibe
  local h = self.hitbox
  return (MOUSE_X >= h.x and MOUSE_X <= h.x+h.w and MOUSE_Y >= h.y and MOUSE_Y <= h.y+h.h)
end

function button:isPress() 
  return MOUSE_IS_PRESS and MOUSE_WAS_PRESS == false and button.isHover(self)
end

return button
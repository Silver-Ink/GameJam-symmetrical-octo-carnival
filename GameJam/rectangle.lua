
local rect = {}

rect.create = function(x, y, w, h)
  return { x = x, y = y, w = w, h = h}
end

--love.graphics.push()
--love.graphics.setColor(colorR, colorG, colorB)
--love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
--love.graphics.pop()
--love.graphics.setColor(1,1,1)

function rect:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return rect
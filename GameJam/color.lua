
local color = {}

color.create = function(r, g, b, a)
  r = r or 1
  g = g or r
  b = b or g
  a = a or 1
  return { r=r, g=g, b=b, a=a}
end

color.white = color.create(1)

function color:apply()
  love.graphics.setColor(self.r,self.g,self.b,self.a)
end

return color
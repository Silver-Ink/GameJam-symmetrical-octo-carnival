
local color = {}

color.create = function(r, g, b, a)
  r = r or 1
  g = g or r
  b = b or g
  a = a or 1
  return { r=r, g=g, b=b, a=a}
end

color.lerp = function(oldColor, newColor, friction)
  friction = friction or 0.9
  local rfriction = 1-friction
  return color.create(oldColor.r*friction + newColor.r*rfriction, oldColor.g*friction + newColor.g*rfriction, oldColor.b*friction + newColor.b*rfriction, oldColor.a*friction + newColor.a*rfriction)
end

color.white = color.create(1)
color.black = color.create(0)
color.gray = color.create(0.5)

function color:apply()
  love.graphics.setColor(self.r,self.g,self.b,self.a)
end

return color
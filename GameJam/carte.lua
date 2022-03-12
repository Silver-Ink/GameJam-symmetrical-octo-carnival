local carte = {}

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  return newCarte
end

function carte:Stroke(x1, y1, x2, y2)

  love.graphics.setCanvas(self.image)

  love.graphics.clear(1, 1, 1, 0.4)
  love.graphics.line(x1, y1, x2, y2)

  love.graphics.setCanvas()
  
end

function carte:Draw()
  love.graphics.draw(self.image, 150, 150, time / 10, 0.5, 0.5)
end

return carte
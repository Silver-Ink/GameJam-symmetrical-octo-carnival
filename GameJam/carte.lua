local carte = {}




function carte:Clear()
  love.graphics.setCanvas(self.image)

  love.graphics.clear(1, 1, 1, 0)
  love.graphics.draw(love.graphics.newImage("Content/carteBG.png"))

  love.graphics.setCanvas()
end

function carte:Stroke()

  love.graphics.setCanvas(self.image)
  love.graphics.setPointSize(5)
  love.graphics.point(MOUSE_X, MOUSE_Y)
  

  love.graphics.setCanvas()
  
end

function carte:Update()
  if love.mouse.isDown(1) then
    self.Stroke()
  end
end

function carte:Draw()
  love.graphics.draw(self.image, 100, 100)
end

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  carte.Clear(newCarte)
  return newCarte
end

return carte
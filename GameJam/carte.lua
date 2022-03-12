local carte = {}

carte.Clear = function(pCarte)
  love.graphics.setCanvas(pCarte.image)

  love.graphics.clear(1, 1, 1, 0)
  love.graphics.draw(love.graphics.newImage("Content/carteBG.png"))

  love.graphics.setCanvas()
end

carte.Stroke = function(pCarte)

  love.graphics.setCanvas(pCarte.image)
  love.graphics.setPointSize(5)
  love.graphics.setColor(0, 0, 0)
  love.graphics.line(MOUSE_X, MOUSE_Y, OLD_MOUSE_X, OLD_MOUSE_Y)
  love.graphics.setColor(1, 1, 1)
  print("ok")


  love.graphics.setCanvas()
  
end

carte.Update = function(pCarte)
  if love.mouse.isDown(1) then
    carte.Stroke(pCarte)
  end
  if love.keyboard.isDown("p") then
    carte.Clear(pCarte)
  end
end

carte.Draw = function(pCarte)
  love.graphics.draw(pCarte.image, 0, 0)
end

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  carte.Clear(newCarte)
  return newCarte
end

return carte
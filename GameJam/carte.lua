local carte = {}

carte.BG = love.graphics.newImage("Content/carteBG.png")

carte.Clear = function(pCarte)
  love.graphics.setCanvas(pCarte.image)

  love.graphics.clear(1, 1, 1, 0)
  love.graphics.setCanvas()
end

carte.Stroke = function(pCarte)

  love.graphics.setCanvas(pCarte.image)
  love.graphics.setLineWidth( TIME )
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("fill", MOUSE_X, MOUSE_Y, TIME/ 2)
  love.graphics.line(MOUSE_X, MOUSE_Y, OLD_MOUSE_X, OLD_MOUSE_Y)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setCanvas()
  
end

carte.Erase = function(pCarte)
  
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
  love.graphics.draw(carte.BG, WIDTH / 2, HEIGHT / 2, 0, 1, 1, WIDTH / 2, HEIGHT /2)
  love.graphics.draw(pCarte.image, 0, 0)
end

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  carte.Clear(newCarte)
  return newCarte
end

return carte
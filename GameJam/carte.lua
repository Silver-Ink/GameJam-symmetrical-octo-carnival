local carte = {}

local Coef = 6

carte.BG = love.graphics.newImage("Content/carteBG.png")

carte.Clear = function(pCarte)
  love.graphics.setCanvas(pCarte.image)

  love.graphics.clear(1, 1, 1, 0)
  love.graphics.setCanvas()
end

carte.Stroke = function(pCarte, r, g, b, size)

  love.graphics.setCanvas(pCarte.image)
  love.graphics.setLineWidth(size/CAM_SCALE)
  love.graphics.setColor(r, g, b)
  love.graphics.circle("fill", MOUSE_X/CAM_SCALE, MOUSE_Y/CAM_SCALE, size/2/CAM_SCALE) --TIME/ 2)
  love.graphics.line(MOUSE_X/CAM_SCALE, MOUSE_Y/CAM_SCALE, OLD_MOUSE_X/CAM_SCALE, OLD_MOUSE_Y/CAM_SCALE)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setCanvas()
  
end

carte.StrokePos = function(pCarte, r, g, b, x, y, oldx, oldy, size)

  love.graphics.setCanvas(pCarte.image)
  love.graphics.setLineWidth(size/CAM_SCALE)
  love.graphics.setColor(r, g, b)
  love.graphics.circle("fill", x/CAM_SCALE, y/CAM_SCALE, size/2/CAM_SCALE) --TIME/ 2)
  --love.graphics.line(x*CAM_SCALE, y*CAM_SCALE, oldx*CAM_SCALE, oldy*CAM_SCALE)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setCanvas()
  
end

carte.Erase = function(pCarte)
  
end

carte.Update = function(pCarte)
  if(USE_MAP) then
    if love.mouse.isDown(1) then
      carte.Stroke(pCarte, 0, 0, 0, 5)
    end
    if love.mouse.isDown(2) then
      carte.Stroke(pCarte, 148/256, 114/256, 64/256, 5*2)
    end
    if love.keyboard.isDown("p") then
      carte.Clear(pCarte)
    end
  end

  if(Game ~= nil) then
    for i = 1, Game.MAX_ELEMENT do
      local e = Game.elements[i]
      if(e.isUsed and e.type == "player" and e.mid == MID) then
        --print("test")
        carte.StrokePos(pCarte, 0.35, 0.35, 0.35, e.hitbox.x*Coef+WIDTH/2, e.hitbox.y*Coef+HEIGHT/2, e.hitbox.x*Coef+WIDTH/2, e.hitbox.y*Coef+HEIGHT/2, 4)
      end
    end
  end



end

carte.Draw = function(pCarte)
  love.graphics.draw(carte.BG, WIDTH / 2, HEIGHT / 2, 0, 1, 1, WIDTH / 2, HEIGHT /2)
  love.graphics.draw(pCarte.image, 0, 0)
  love.graphics.print("P : Clear", 50, HEIGHT-90, 0, FONT_NORMAL)
  love.graphics.print("Click gauche/droit: dessiner", 50, HEIGHT-50, 0, FONT_NORMAL)

  if(Game ~= nil) then
      for i = 1, Game.MAX_ELEMENT do
    local e = Game.elements[i]
    if(e.isUsed and e.type == "player" and e.mid == MID) then
      love.graphics.circle("fill", e.hitbox.x*Coef+WIDTH/2, e.hitbox.y*Coef+HEIGHT/2, 4)
    end
  end
  end
end

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  carte.Clear(newCarte)
  return newCarte
end

return carte
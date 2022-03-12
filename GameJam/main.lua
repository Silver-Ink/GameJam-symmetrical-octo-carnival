love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool

function love.load()
  love.window.setTitle("<NOM DU JEU> (by Wile)")
  --love.window.setMode(1280, 768)
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
end

function love.update(dt)
  print("dt : "..dt)
end

function love.draw()
end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)
end

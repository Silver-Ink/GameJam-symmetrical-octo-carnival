love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool

local test = require("extern")

function love.load()
  love.window.setTitle("<NOM DU JEU> (by Wile)")
  local scaleDiv = 2
  love.window.setMode(1920 / scaleDiv, 1080 / scaleDiv)
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight()
  Img = love.graphics.newImage("Content/sus.png")

  local f = love.graphics.newFont("Content/JosefinSans-Regular.ttf", HEIGHT/10)
	love.graphics.setFont(f)
  test.test(42)
end

function love.update(dt)
  print("dt : "..dt)
  --table.insert(t, 1)
  --Img:getWidth()

end

function love.draw()
  love.graphics.draw(Img)
  love.graphics.print("Hello World", 400, 300, 0.2, 0.5)
end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)
end

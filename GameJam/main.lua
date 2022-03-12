--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool

WIDTH  = 1
HEIGHT = 1

function love.load()
  love.window.setTitle("<NOM DU JEU> (by Wile)")
  WIDTH  = 960 --love.graphics.getWidth()
  HEIGHT = 540 --love.graphics.getHeight()
  FULLSCREEN = false
  FSTYPE = {resizable=false, fullscreen = FULLSCREEN, vsync=true, minwidth=WIDTH/2, minheight=HEIGHT/2}
  love.window.setMode(WIDTH, HEIGHT, FSTYPE)

  Img = love.graphics.newImage("Content/sus.png")
  require("font").load()
end

function love.update(dt)
  --print("dt : "..dt)
  --table.insert(t, 1)
  --Img:getWidth()
end

function love.draw()
  local scale = math.min(love.graphics.getWidth()/WIDTH, love.graphics.getHeight()/HEIGHT)
  love.graphics.scale(scale, scale)

  love.graphics.draw(Img)
  love.graphics.print("F11 Full Screen",    400, 100, 0, FONT_BIG)
  love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then love.event.quit()
  elseif key == "f11" then
    FULLSCREEN = not FULLSCREEN
		love.window.setFullscreen(FULLSCREEN)
	end
end
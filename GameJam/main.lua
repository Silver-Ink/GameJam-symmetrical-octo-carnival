--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool


--GLOBALES 
WIDTH  = 1
HEIGHT = 1
TIME = 0
CAM_SCALE = 1

IS_SERVEUR = false


-- CLASSES 
local Ccarte = require("carte")
SCENE  = require("reseau")
local rect   = require("rectangle")
local mouse  = require("mouse")

-- INSTANCES
local carte

function love.load()
  love.window.setTitle("<NOM DU JEU> (by Wile)")
  WIDTH  = 960 --love.graphics.getWidth()
  HEIGHT = 540 --love.graphics.getHeight()
  FULLSCREEN = false
  FSTYPE = {resizable=false, fullscreen = FULLSCREEN, vsync=true, minwidth=WIDTH/2, minheight=HEIGHT/2}
  love.window.setMode(WIDTH, HEIGHT, FSTYPE)
  ImgThomasDP = love.graphics.newImage("Content/sus.png")

  carte = Ccarte.Create()
  require("font").load()
  SCENE.load()
end

function love.update(dt)
  mouse.update()
  SCENE.update(dt)

  if IS_SERVEUR then
    reseau.searchNewPlayer()
  end

  if love.keyboard.isDown("m") then
    Ccarte.Update(carte)
  end

  --print("dt : "..dt)
  --table.insert(t, 1)
  --Img:getWidth()
  TIME = TIME + dt
end

function love.draw()
  CAM_SCALE = math.min(love.graphics.getWidth()/WIDTH, love.graphics.getHeight()/HEIGHT)
  love.graphics.scale(CAM_SCALE, CAM_SCALE)

  --love.graphics.draw(ImgThomasDP)
  --love.graphics.print("Main.lua",    10, 10, 0, FONT_BIG)
  --love.graphics.print("F11 Full Screen",    400, 100, 0, FONT_BIG)
  --love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  --love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  --love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)

  SCENE.draw()

  if love.keyboard.isDown("m") then
      Ccarte.Draw(carte)
    end
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then love.event.quit()
  elseif key == "f11" then
    FULLSCREEN = not FULLSCREEN
		love.window.setFullscreen(FULLSCREEN)
	end
end
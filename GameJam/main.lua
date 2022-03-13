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

USE_MAP=  false

_OLD_KEY_M_PRESS = false

function love.load()
  love.window.setTitle("A La Carte (by 4 Pizz)")
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

  Ccarte.Update(carte)



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
  
  local mPress = love.keyboard.isDown("m")
  if mPress and _OLD_KEY_M_PRESS == false  then
    USE_MAP = not USE_MAP
  end
  _OLD_KEY_M_PRESS = mPress


  if(USE_MAP) then
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
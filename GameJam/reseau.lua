local reseau = {}

local button = require("button")
local rect = require("rectangle")
local color = require("color")

reseau.load = function()
  local w, h = 128, 96
  reseau.b1 = button.create(rect.create(WIDTH/2+32,HEIGHT/2,w,h), color.create(1, 0, 0), "Host")
  reseau.b2 = button.create(rect.create(WIDTH/2-32-w,HEIGHT/2,w,h), color.create(0, 1, 0), "Join")
  print("reseaux")
end

reseau.update = function(dt)
  if button.isPress(reseau.b1) then
    Thread = love.thread.newThread("client.lua", "client")
    --start the thread
    Thread:start()
    print("boutton b1")

    SCENE = require("game")
    SCENE.load()
    SCENE.initDefaultLevel()
    SCENE.loadLocalPlayer()
  end

  if button.isPress(reseau.b2) then
    Thread = love.thread.newThread("serveur.lua", "serv")
    --start the thread
    Thread:start()
    print("boutton b2")

    SCENE = require("game")
    SCENE.load()
    SCENE.loadLocalPlayer()
  end

end

reseau.draw = function()


  button.draw(reseau.b1)
  button.draw(reseau.b2)
  --reseau.b1.draw()
end

return reseau
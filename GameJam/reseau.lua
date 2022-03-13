local reseau = {}

local button = require("button")
local rect = require("rectangle")
local color = require("color")

reseau.load = function()
  reseau.b1 = button.create(rect.create(64,64,128,128), color.create(1, 0, 0))
  reseau.b2 = button.create(rect.create(64+256*1,64,128,128), color.create(0, 1, 0))
  print("reseaux")
end


local server
local lst_client
local nbPlayer


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
    lst_client = {}
    nbPlayer = 0
    -- load namespace
    local socket = require("socket")
    -- create a TCP socket and bind it to the local host, at port 4242
    server = assert(socket.bind("*", 4242))
    -- find out which port the OS chose for us
    local ip, port = server:getsockname()
    -- print a message informing what's up
    print("Please telnet to localhost on port " .. port)
  
    nbPlayer = nbPlayer + 1

    MID = nbPlayer
    


    print("boutton b2")

    SCENE = require("game")
    SCENE.load()
    SCENE.initDefaultLevel()
    SCENE.loadLocalPlayer()
  end

end

reseau.draw = function()


  button.draw(reseau.b1)
  button.draw(reseau.b2)
  --reseau.b1.draw()
end

reseau.searchNewPlayer = function()
  -- wait for a connection from any client
  server:settimeout(0.001)
  local client = server:accept()
  -- make sure we don't block waiting for this client's line
  lst_client[nbPlayer] = client


  local c1 = {}
  Thread = love.thread.newThread("serveurCom.lua", "servClient")
  c1    = love.thread.newChannel()
  --start the thread
  c1:push({client, nbPlayer})
  Thread:start(c1)

  nbPlayer = nbPlayer + 1









  
  

  nbPlayer = nbPlayer + 1

  for i = 1, nbPlayer-2 do
      lst_client[i]:send("New player\n") 
      -- if there was no error, send it back to the client
  end



end

return reseau
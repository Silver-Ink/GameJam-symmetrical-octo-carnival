local reseau = {}

local button = require("button")
local rect = require("rectangle")
local color = require("color")
local sprite = require("sprite")

local function getFuncId(funcPtr)
  if(funcPtr == nil) then
    return 1
  end
  return GameFunc[funcPtr]
end

local function getFuncFromId(FuncId)
  return GameFunc[FuncId]
end

local tcp
local myPlayer

local function clientconnect(nbPlayer)
  local s, status, partial = tcp:receive()
  if(tonumber(s) ~= Game.MAX_ELEMENT) then
    print("on ferme")
      os.exit()
  end
  if(myPlayer ~= nil) then
    tcp:send(myPlayer.hitbox.x .. "\n")
    tcp:send(myPlayer.hitbox.y .. "\n")
  end


  local k
  for i = 1, Game.MAX_ELEMENT do
      s, status, partial = tcp:receive()
      if(s == "NOTHING") then
          Game.elements[i].isUsed = false
      else
          while s ~= "FINI" do
              if(s == "draw" or s == "update") then
                  k, status, partial = tcp:receive()
                  Game.elements[i][s] = require(getFuncFromId(tonumber(k)))
                  
              elseif(s == "hitbox") then
                  local u, status, partial = tcp:receive()
                  while u ~= "SEMIFIN" do
                      local p, status, partial = tcp:receive()
                      Game.elements[i][s][u] = p
                      u, status, partial = tcp:receive()
                  end
              elseif s == "sprite" then
                  local u, status, partial = tcp:receive()
                  while u ~= "SEMIFIN" do
                      local p, status, partial = tcp:receive()
                      if(u == "path") then
                        Game.elements[i].sprite = sprite.create(p)
                      end
                      
                      u, status, partial = tcp:receive()
                  end
              else
                  k, status, partial = tcp:receive()
                  if(k == "true") then
                    k = true
                  elseif k == "false" then
                    k = false
                  end
                  Game.elements[i][s] = k
                  if s == "mid" then
                    if k == nbPlayer then
                      myPlayer = Game.elements[i]
                    end
                  end
              end
              s, status, partial = tcp:receive()
          end
      end

  end
  tcp:send("OKAY\n")




end






function OpenConnect(client, nbPlayer)
  -- receive the line
  local y, err, status
  local x
  local recu = false
  while not recu do
      client:send(Game.MAX_ELEMENT .. "\n")

      if(tonumber(nbPlayer) ~= -1) then
        x, err, status = client:receive()
        y, err, status = client:receive()
        print(x .. " x")
        print(y .. " y")
      end



      for i = 1,Game.MAX_ELEMENT do
          if not (Game.elements[i].isUsed) then
              client:send("NOTHING\n")
          else
            if(Game.elements[i].mid == nbPlayer+1) then
              Game.elements[i].hitbox.x = tonumber(x)
              Game.elements[i].hitbox.y = tonumber(y)
            end
              for k, v in pairs(Game.elements[i]) do
                  client:send(k .. "\n")
                  if(k == "draw" or k == "update") then
                    local tmp = getFuncId(v)
                    
                    client:send( tonumber(tmp) .. "\n")
                      
                  elseif(k == "hitbox" or k == "sprite") then
                      for u, m in pairs(Game.elements[i][k]) do
                          if(u ~= "quad" and u ~= "image") then
                              if(m ~= nil and u ~= nil and u ~= " ")then
                              client:send(u .. "\n")
                              client:send(m .. "\n")
                              end
                          end
                      end
                      client:send("SEMIFIN\n")
                  else
                      if(v == true)then
                        v = "true"
                      elseif(v == false) then
                        v = "false"
                      end
                      client:send(v .. "\n")
                  end
              end
              client:send("FINI\n")
          end
      end
      local line, err, status = client:receive()
      if line == "OKAY" then
          recu = true
      elseif status == "closed" then
        os.exit()
      end
  end
end


reseau.load = function()
  local w, h = 128, 96
  reseau.b1 = button.create(rect.create(WIDTH/2+32,HEIGHT/2,w,h), color.create(1, 0, 0), "Join")
  reseau.b2 = button.create(rect.create(WIDTH/2-32-w,HEIGHT/2,w,h), color.create(0, 1, 0), "Host") --"Join\nMathieu pour les fonctions on les\nstocks dans le tableau\ndans gameFunc.lua ?")
  print("reseaux")
end


local server
local lst_client
local nbPlayer


reseau.update = function(dt)
  if button.isPress(reseau.b1) then
    SCENE = require("game")
    SCENE.load()

    local nbPlayer
    local host, port = "localhost", 4242
    local socket = require("socket")
    tcp = assert(socket.tcp())
    tcp:connect(host, port);
    --note the newline below
    local pseudo = "Je suis pas toi!!"
    tcp:send(pseudo .. "\n");

    local s, status, partial = tcp:receive()
    MID = s
    nbPlayer = s
    IS_CLIENT = true

    clientconnect(nbPlayer)
    print("boutton b1")




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
    
    IS_SERVEUR = true

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

reseau.listenServ = function ()
  clientconnect()
end



reseau.searchNewPlayer = function()
  -- wait for a connection from any client
  server:settimeout(0.001)
  local client, err = server:accept()

  if err then
    for i = 1, nbPlayer-1 do
      OpenConnect( lst_client[i], i)
    end
    return nil
  end

  -- make sure we don't block waiting for this client's line
  lst_client[nbPlayer] = client
 

  --GameFunc
  
    local line, err = client:receive()
    if not err then 
        if not (line == "") then
            --client:send(line .. " : recu du client" .. i.. +"\n") 
            --print(line .. " : recu du client ".. nbPlayer) -- On ne garde pas le pseudo pour le moment
            client:send(nbPlayer+1 .. "\n") 
        end
    else
        print("Erreur avec le client")
        -- done with client, close the object
        client:close()
    end

    print(nbPlayer)
  require("element._loadStickman")(Game, {mid = nbPlayer+1})

  OpenConnect(client, -1)

 nbPlayer = nbPlayer + 1

  



  --[[for i = 1, nbPlayer-2 do
      lst_client[i]:send("New player\n") 
      -- if there was no error, send it back to the client
  end
--]]


end






return reseau
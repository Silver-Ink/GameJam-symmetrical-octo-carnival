local function connect()

    MID = -1
    local nbPlayer
    local host, port = "192.168.43.227", 4242 --"localhost", 4242
    local socket = require("socket")
    local tcp = assert(socket.tcp())
  
    tcp:connect(host, port);
    --note the newline below
    local pseudo = "Je suis pas toi!!"
    tcp:send(pseudo .. "\n");

    local s, status, partial = tcp:receive()
    MID = s
    nbPlayer = s

    while true do
        local s, status, partial = tcp:receive()
        
        if s == "New player" then
            nbPlayer = nbPlayer + 1
            print("Il y a " .. nbPlayer .. " joueur d'apres" .. MID)
        end

        --print(s or partial .. " + recu du serveur\n")

        if status == "closed" then print("on sort du client")break end

    end

    tcp:close()
  
end


  connect()

 
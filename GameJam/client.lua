function connect()

    local myNumber
    local nbPlayer
    local host, port = "localhost", 4242
    local socket = require("socket")
    local tcp = assert(socket.tcp())
  
    tcp:connect(host, port);
    --note the newline below
    local pseudo = "Je suis pas toi!!"
    tcp:send(pseudo .. "\n");

    local s, status, partial = tcp:receive()
    myNumber = s
    nbPlayer = s

    while true do
        local s, status, partial = tcp:receive()
        
        if s == "New player" then
            nbPlayer = nbPlayer + 1
            print("Il y a " .. nbPlayer .. " joueur d'apres" .. myNumber)
        end

        --print(s or partial .. " + recu du serveur\n")

        if status == "closed" then print("on sort du client")break end

    end

    tcp:close()
  
end


  connect()

 
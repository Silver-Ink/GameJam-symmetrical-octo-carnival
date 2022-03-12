function openConnect()

    local lst_client = {}

    local nbPlayer = 0
  
    -- load namespace
    local socket = require("socket")
  
    -- create a TCP socket and bind it to the local host, at port 4242
    local server = assert(socket.bind("*", 4242))
  
    -- find out which port the OS chose for us
    local ip, port = server:getsockname()
  
    -- print a message informing what's up
    print("Please telnet to localhost on port " .. port)
  
    nbPlayer = nbPlayer + 1
  
    -- loop forever waiting for clients
    while 1 do


        -- wait for a connection from any client
        local client = server:accept()

        -- make sure we don't block waiting for this client's line
        lst_client[nbPlayer] = client
        

        -- receive the line
        local line, err = lst_client[nbPlayer]:receive()
        lst_client[nbPlayer]:settimeout(5)
        if not err then 
            if not (line == "") then
                --client:send(line .. " : recu du client" .. i.. +"\n") 
                print(line .. " : recu du client ".. nbPlayer)
                lst_client[nbPlayer]:send(nbPlayer+1 .. "\n") 
            end
        else
            print("Erreur avec le client")
            -- done with client, close the object
            lst_client[nbPlayer]:close()
        end


        nbPlayer = nbPlayer + 1


        

        for i = 1, nbPlayer-2 do
            lst_client[i]:send("New player\n") 
            -- if there was no error, send it back to the client
            
        end

        
    end
end

openConnect()
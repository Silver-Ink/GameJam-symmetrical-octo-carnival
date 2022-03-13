local c1 = {}
local input = c1:demand()

function OpenConnect(client, nbPlayer)

    -- receive the line
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

    local recu = false
    while not recu do
        client:send(game.MAX_ELEMENT .. "\n")
        for i = 1, game.MAX_ELEMENT do
            client:send(game.elements[i] .. "\n")
          end
    end


end







OpenConnect(input[0], input[1])
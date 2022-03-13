local mapLoader = {}

local tileInit = require("element.tileInit")

local function placeSolidBlock(x, y, texture)
  Game.create(tileInit, {x=x, y=y, name=texture or "wall.png"}, nil, nil)
end

mapLoader.load = function (game)
  local t = require("element.tileInit")

  for x = 0, 10 do
    for y = 0, 6 do

      if((x+y)%8==0) then
        placeSolidBlock(x,y)
      end
    end
  end
end

return mapLoader
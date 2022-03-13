local mapLoader = {}

mapLoader.load = function (game)
  local t = require("element.tileInit")

  for x = 0, 10 do
    for y = 0, 6 do

      --[[
      local drawMethod = nil
      if((x)%4==0) then
        drawMethod = require("element.tileDraw2")
      end]]
      if((x+y)%8==0) then
      game.create(t, {x=x, y=y, name="wall.png"}, nil, nil)
      end
    end
  end
end

return mapLoader
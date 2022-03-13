local mapLoader = {}
local mazeGenerator = require("maze")


mazeGenerator.Generate()




local tileInit = require("element.tileInit")

local function placeSolidBlock(x, y, texture)
  local textures = {"wall.png","epouventail.png","tree_1.png","plot.png"}

  local r = math.random()
  local alt = ""
  if r < 0.85 then
    alt = textures[1]
  elseif r < 0.9 then
    alt = textures[3]
  elseif r < 0.95 then
    alt = textures[2]
  else
    alt = textures[4]
  end
  Game.create(tileInit, {x=2*x , y=2*y , name=texture or alt, hx=2,hy=2 }, nil, nil)
end

local function placeNonSolidBlock(x, y, texture, updateMethod)
  Game.create(tileInit, {x=2*x , y=2*y , name=texture or "chest_red_close.png", hx=2,hy=2,isSolid = false}, updateMethod, nil)
end



mapLoader.load = function (_)

  for row=1,mazeGenerator.numberOfRows do 
    for column=1,mazeGenerator.numberOfColumns do
      if mazeGenerator.grid[row][column] == "wall" then
        placeSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2) 
      end
      if mazeGenerator.grid[row][column] == "chest1" or mazeGenerator.grid[row][column] == "chest2" then
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_red_close.png", require("element.logic.chestUpdate"))
      end
    end

  end
end

return mapLoader
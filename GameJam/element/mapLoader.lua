local mapLoader = {}
local mazeGenerator = require("maze")


mazeGenerator.Generate()



local coefScale = 2
local tileInit = require("element.tileInit")

local function placeSolidBlock(x, y, texture)
  local textures = {"wall.png","epouventail.png","tree_1.png","plot.png"}

  local r = math.random()
  local alt = ""
  if r < 0.95 then
    alt = textures[1]
  elseif r < 0.97 then
    alt = textures[3]
  elseif r < 0.99 then
    alt = textures[2]
  else
    alt = textures[4]
  end
  Game.create(tileInit, {x=coefScale*x , y=coefScale*y , name=texture or alt, hx=coefScale,hy=coefScale }, nil, nil)
end

local function placeNonSolidBlock(x, y, texture, updateMethod)
  Game.create(tileInit, {x=coefScale*x , y=coefScale*y , name=texture, hx=coefScale,hy=coefScale,isSolid = false}, updateMethod, nil)
end



mapLoader.load = function (_)

  local hasLeft = true
  local hasTop = false

  local exitX, exitY = 0,0

  for row=1,mazeGenerator.numberOfRows do 
    for column=1,mazeGenerator.numberOfColumns do
      if mazeGenerator.grid[row][column] == "wall" then
        if row <= 2 or row >= mazeGenerator.numberOfRows - 2 or column <= 2 or column >= mazeGenerator.numberOfColumns - 2 then
          placeSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"wall.png")
        else
          placeSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2) 
        end
        hasLeft = false
      end
      if mazeGenerator.grid[row][column] == "chest1" then
        hasLeft = false
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_red_close.png", require("element.logic.chestUpdate"))
      elseif mazeGenerator.grid[row][column] == "chest2" then
        hasLeft = false
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_blue_close.png", require("element.logic.chestUpdate"))
      elseif mazeGenerator.grid[row][column] == "chest3" then
        hasLeft = false
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_green_close.png", require("element.logic.chestUpdate"))
      elseif mazeGenerator.grid[row][column] == "chest4" then
        hasLeft = false
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_silver_close.png", require("element.logic.chestUpdate"))
      elseif mazeGenerator.grid[row][column] == "bonusChest" then
        hasLeft = false
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,"chest_yellow_close.png", require("element.logic.chestUpdate"))
      
      elseif mazeGenerator.grid[row][column] == "spawn" then
        local tile = ""
        if row > 1 and mazeGenerator.grid[row-1][column] == "wall" then
          hasTop = false
        elseif row % 2 ~= 0  then
          hasTop = false
        elseif row %2 == 0 then
          hasTop = true
        end

        if column > 1 and mazeGenerator.grid[row][column-1] == "wall" then
          hasLeft = false
        elseif column % 2 == 1 then
          hasLeft = false
        elseif column % 2 == 0 then
          hasLeft = true
        end
        if hasLeft and hasTop then
          tile = "br_tile.png"  
        elseif hasLeft and not(hasTop) then
          tile = "tr_tile.png"
        elseif not(hasLeft) and hasTop then
          tile = "bl_tile.png"
        elseif not(hasLeft) and not(hasTop) then
          tile = "tl_tile.png"
        end
        hasLeft = not(hasLeft)
        placeNonSolidBlock(column - mazeGenerator.numberOfColumns/2,row - mazeGenerator.numberOfRows/2,tile,nil)
      end
      
      if mazeGenerator.grid[row][column] == "exit" then
        exitX = (column - mazeGenerator.numberOfColumns/2)
        exitY = (row - mazeGenerator.numberOfRows/2)
        placeNonSolidBlock(exitX, exitY,"trape_close.png")
      end
    end
  
  end

  local angle = math.random()*2*math.pi --math.atan(exitY, exitX)
  --print(angle)
  for i = -4, 4 do
    if(i ~= 0) then
      placeNonSolidBlock(exitX+math.cos(angle)*i*-8, exitY+math.sin(angle)*i*-8, "eye.png")
    end
  end

  
end

return mapLoader
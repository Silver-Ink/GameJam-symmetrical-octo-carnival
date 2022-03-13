local mazeGenerator = {}

mazeGenerator.grid = {}
mazeGenerator.numberOfColumns = 0
mazeGenerator.numberOfRows = 0
mazeGenerator.cellSize = 5 *3 
mazeGenerator.exitBoundaryExtendFactor = 0.5 
mazeGenerator.SpawningAreaTop = 0
mazeGenerator.SpawningAreaLeft = 0
mazeGenerator.SpawningAreaSize = 4 * 3  --doit etre un multiple de 4
mazeGenerator.bonusChestExtendFactor  = 0.6
mazeGenerator.numberOfBonusChests = 2
mazeGenerator.numberOfChests1 = 1
mazeGenerator.numberOfChests2 = 1
mazeGenerator.numberOfChests3 = 1
mazeGenerator.numberOfChests4 = 1
mazeGenerator.regularChestsExtendFactor = 0.8

local explored = 0
local seed = os.clock()
local maxNumberOfTriesForDoorsBySide = 20





function mazeGenerator.DigWallAt(row, column)
    mazeGenerator.grid[row][column] = "path"
  end
  
  
  function mazeGenerator.GenerateExit()
  
    local row = 0
    local column = 0
    
    while true do
     
      row = math.random(1,mazeGenerator.numberOfRows)
      column = math.random(1,mazeGenerator.numberOfColumns)
      if mazeGenerator.IsInsideExitArea(row,column) == true and mazeGenerator.grid[row][column] == "path" then 
        break 
      end
      
    end
    mazeGenerator.grid[row][column] = "exit"
    
  end
  
  function mazeGenerator.IsInsideExitArea(row,column)
    
    local rowTest = (row < mazeGenerator.topExitBoundary or row > mazeGenerator.topExitBoundary + mazeGenerator.exitBoundarySize)
    local columTest = (column < mazeGenerator.leftExitBoundary or column > mazeGenerator.leftExitBoundary + mazeGenerator.exitBoundarySize)
    return rowTest and columTest
  end
  
  
  function mazeGenerator.IsInsideBonusChestsArea(row,column)
    local rowTest = (row >= mazeGenerator.topBonusBoundary and row <= mazeGenerator.topBonusBoundary + mazeGenerator.bonusBoundarySize)
    local columTest = (column >= mazeGenerator.leftBonusBoundary and column <= mazeGenerator.leftBonusBoundary + mazeGenerator.bonusBoundarySize)
    return rowTest and columTest and not(mazeGenerator.IsInsideSpawningAreaExtended(row,column))
  end 

  function mazeGenerator.IsInsideRegularChestsArea(row,column)
    local rowTest = (row >= mazeGenerator.topRegularChestBoundary and row <= mazeGenerator.topRegularChestBoundary + mazeGenerator.regularChestBoundarySize)
    local columTest = (column >= mazeGenerator.leftRegularChestBoundary and column <= mazeGenerator.leftRegularChestBoundary + mazeGenerator.regularChestBoundarySize)
    return rowTest and columTest and not(mazeGenerator.IsInsideSpawningAreaExtended(row,column))
  end

  function mazeGenerator.GetAvailableDirections(row, column)
    local availableDirections = {}
    
  
    if row > 2 then
      if  mazeGenerator.grid[row - 2][column] == "wall" and mazeGenerator.grid[row-1][column] ~= "spawn" then
        table.insert(availableDirections, "up")
      end
    end
    if column < mazeGenerator.numberOfColumns - 2 then
      if mazeGenerator.grid[row][column + 2] == "wall"  and mazeGenerator.grid[row][column+1] ~= "spawn" then
        table.insert(availableDirections, "right")
      end
    end
    if row < mazeGenerator.numberOfRows - 2 and mazeGenerator.grid[row+1][column] ~= "spawn"then
      if mazeGenerator.grid[row + 2][column] == "wall"  and mazeGenerator.grid[row-1][column] ~= "spawn" then
        table.insert(availableDirections, "down")
      end
    end
    if column > 2 then
      if mazeGenerator.grid[row][column - 2] == "wall" and mazeGenerator.grid[row-1][column] ~= "spawn" then
        table.insert(availableDirections, "left")
      end
    end
    
    return availableDirections
  end
  
  
  function mazeGenerator.Explore(row, column)
    mazeGenerator.DigWallAt(row, column)
    explored = explored + 1
  
    
    while explored < math.floor((mazeGenerator.numberOfRows*mazeGenerator.numberOfColumns) / 2) do
      local dirs = mazeGenerator.GetAvailableDirections(row, column)
      if #dirs ~= 0 then
        local r = love.math.random(1, #dirs)
        local direction = dirs[r]
        if direction == "up" then
            mazeGenerator.DigWallAt(row - 1, column)
            mazeGenerator.Explore(row - 2, column)
        elseif direction == "right" then
            mazeGenerator.DigWallAt(row , column + 1)
            mazeGenerator.Explore(row , column + 2)
        elseif direction == "down" then
            mazeGenerator.DigWallAt(row + 1, column)
            mazeGenerator.Explore(row + 2, column)
        elseif direction == "left" then
            mazeGenerator.DigWallAt(row, column - 1)
            mazeGenerator.Explore(row, column - 2)
        end
      else
        break
      end
    end
  end
  
  function mazeGenerator.IsInsideSpawningArea(row,column)
    
    local rowTest = (row >= mazeGenerator.SpawningAreaTop and row <= mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize )
    local columTest = (column >= mazeGenerator.SpawningAreaLeft and column <= mazeGenerator.SpawningAreaLeft + mazeGenerator.SpawningAreaSize )
  
    return rowTest and columTest
  end

  function mazeGenerator.IsInsideSpawningAreaExtended(row,column)
    
    local rowTest = (row >= mazeGenerator.SpawningAreaTop - 1 and row <= mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize + 1)
    local columTest = (column >= mazeGenerator.SpawningAreaLeft - 1 and column <= mazeGenerator.SpawningAreaLeft + mazeGenerator.SpawningAreaSize + 1 )
  
    return rowTest and columTest
  end

  
  
  function mazeGenerator.GetRowIndex(x)
    return math.floor(x / mazeGenerator.cellSize)
  end
  
  function mazeGenerator.GetColumnIndex(y)
    return math.floor(y / mazeGenerator.cellSize)
  end
  
  function mazeGenerator.GenerateSpawningAreaDoorsToTheLeft()
    for i = 1, maxNumberOfTriesForDoorsBySide do
      local row = love.math.random(mazeGenerator.SpawningAreaTop + 1, mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize - 1)
  
      local possible = true
  
      if mazeGenerator.grid[row][mazeGenerator.SpawningAreaLeft -  2] ~= "path" then
        possible = false
      end
  
     
  
      if possible then
        
        mazeGenerator.grid[row][mazeGenerator.SpawningAreaLeft-1] = "door"
          
        
        break
      end
    end
  end
  
  
  
  function mazeGenerator.GenerateSpawningAreaDoorsToTheRight()
    for i = 1, maxNumberOfTriesForDoorsBySide do
      local row = love.math.random(mazeGenerator.SpawningAreaTop + 1, mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize - 1)
  
      local possible = true
      if mazeGenerator.grid[row][mazeGenerator.SpawningAreaLeft + mazeGenerator.SpawningAreaSize +  2] ~= "path" then
        possible = false
      end
  
      if possible then
        if mazeGenerator.grid[row][mazeGenerator.SpawningAreaLeft + mazeGenerator.SpawningAreaSize  + 1] == "wall" then
            mazeGenerator.grid[row][mazeGenerator.SpawningAreaLeft + mazeGenerator.SpawningAreaSize + 1] = "door"
          
          break
        end
      end
    end
  end
  

  function mazeGenerator.GenerateSpawningAreaDoorsToTheTop()
    for i = 1, maxNumberOfTriesForDoorsBySide do
      local column = love.math.random(mazeGenerator.SpawningAreaLeft + 1, mazeGenerator.SpawningAreaLeft   + mazeGenerator.SpawningAreaSize - 1)
  
      local possible = true
      if mazeGenerator.grid[mazeGenerator.SpawningAreaTop - 2][column] ~= "path" then
        possible = false
      end
  
      if possible then
        if mazeGenerator.grid[mazeGenerator.SpawningAreaTop - 1][column] == "wall" then
            mazeGenerator.grid[mazeGenerator.SpawningAreaTop-1][column] = "door"
          
          break
        end
      end
    end
  end
  
  
  function mazeGenerator.GenerateSpawningAreaDoorsToTheBottom()
    for i = 1, maxNumberOfTriesForDoorsBySide do
      local column = love.math.random(mazeGenerator.SpawningAreaLeft + 1, mazeGenerator.SpawningAreaLeft   + mazeGenerator.SpawningAreaSize - 1)
  
      local possible = true
      if mazeGenerator.grid[mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize + 2][column] ~= "path" then
        possible = false
      end
  
      if possible then
        if mazeGenerator.grid[mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize + 1][column] == "wall" then
            mazeGenerator.grid[mazeGenerator.SpawningAreaTop + mazeGenerator.SpawningAreaSize + 1][column] = "door"
          
        
          break
        end
      end
    end
  end
  

  function mazeGenerator.GenerateBonusChest()
    local row = 0
    local column = 0
    local count = 0
    
    while count < mazeGenerator.numberOfBonusChests do
     
      row = math.random(1,mazeGenerator.numberOfRows)
      column = math.random(1,mazeGenerator.numberOfColumns)
      if mazeGenerator.IsInsideBonusChestsArea(row,column) == true and mazeGenerator.grid[row][column] == "path" then 
        mazeGenerator.grid[row][column] = "bonusChest"
        count = count + 1
      end
      
    end    
  end

  function mazeGenerator.GenerateRegularChests()
  
    for i=1,mazeGenerator.numberOfChests1 do
      local row = math.random(1,mazeGenerator.numberOfRows)
      local column = math.random(1,mazeGenerator.numberOfColumns)
      while mazeGenerator.grid[row][column] ~= "path" or mazeGenerator.IsInsideRegularChestsArea(row,column) == false   do
        row = math.random(1,mazeGenerator.numberOfRows)
        column = math.random(1,mazeGenerator.numberOfColumns)
          
      end
      mazeGenerator.grid[row][column] = "chest1"
    end

    for i=1,mazeGenerator.numberOfChests2 do
      local row = math.random(1,mazeGenerator.numberOfRows)
      local column = math.random(1,mazeGenerator.numberOfColumns)
      while mazeGenerator.grid[row][column] ~= "path" or mazeGenerator.IsInsideRegularChestsArea(row,column) == false do
        row = math.random(1,mazeGenerator.numberOfRows)
        column = math.random(1,mazeGenerator.numberOfColumns)
          
      end
      mazeGenerator.grid[row][column] = "chest2"
    end
    
    for i=1,mazeGenerator.numberOfChests3 do
      local row = math.random(1,mazeGenerator.numberOfRows)
      local column = math.random(1,mazeGenerator.numberOfColumns)
      while mazeGenerator.grid[row][column] ~= "path" or mazeGenerator.IsInsideRegularChestsArea(row,column) == false do
        row = math.random(1,mazeGenerator.numberOfRows)
        column = math.random(1,mazeGenerator.numberOfColumns)
          
      end
      mazeGenerator.grid[row][column] = "chest3"
      
    end

    for i=1,mazeGenerator.numberOfChests4 do
      local row = math.random(1,mazeGenerator.numberOfRows)
      local column = math.random(1,mazeGenerator.numberOfColumns)
      while mazeGenerator.grid[row][column] ~= "path" or mazeGenerator.IsInsideRegularChestsArea(row,column) == false do
        row = math.random(1,mazeGenerator.numberOfRows)
        column = math.random(1,mazeGenerator.numberOfColumns)
          
      end
      mazeGenerator.grid[row][column] = "chest4"
    end
  end

  function mazeGenerator.GenerateSpawningAreaDoors()
    mazeGenerator.GenerateSpawningAreaDoorsToTheLeft()
    mazeGenerator.GenerateSpawningAreaDoorsToTheRight()
    mazeGenerator.GenerateSpawningAreaDoorsToTheTop()
    mazeGenerator.GenerateSpawningAreaDoorsToTheBottom()
    
  
  end

  function mazeGenerator.InitGrid()
    for row= 1, mazeGenerator.numberOfRows do
        mazeGenerator.grid[row] = {}
      for column= 1, mazeGenerator.numberOfColumns do
        if mazeGenerator.IsInsideSpawningArea(row,column) then 
            mazeGenerator.grid[row][column] = "spawn" 
        else  
            mazeGenerator.grid[row][column] = "wall"
        end
      end
    end
      
  end
  
  function mazeGenerator.Initialize(startingPointRow, startingPointColumn)
    --fixe la seed rnd
    seed = seed + 1
    love.math.setRandomSeed(seed)
    
    
    mazeGenerator.grid = {}
    explored = 0
    
    mazeGenerator.numberOfColumns = math.floor(800 / mazeGenerator.cellSize)
    mazeGenerator.numberOfRows = math.floor(600 / mazeGenerator.cellSize)
  
    mazeGenerator.SpawningAreaLeft = mazeGenerator.GetColumnIndex(math.floor(800 / 2)) - math.floor(mazeGenerator.SpawningAreaSize / 2)
    mazeGenerator.SpawningAreaTop = mazeGenerator.GetRowIndex(math.floor(600 / 2)) - math.floor(mazeGenerator.SpawningAreaSize / 2)
    
    --Generate exitBoundary specificities
    mazeGenerator.topExitBoundary = mazeGenerator.SpawningAreaTop - mazeGenerator.SpawningAreaSize * mazeGenerator.exitBoundaryExtendFactor
    mazeGenerator.leftExitBoundary = mazeGenerator.SpawningAreaLeft - mazeGenerator.SpawningAreaSize * mazeGenerator.exitBoundaryExtendFactor
    mazeGenerator.exitBoundarySize = mazeGenerator.SpawningAreaSize * (1+2 *mazeGenerator.exitBoundaryExtendFactor)
    

    --Generate bonusBoundary specificities
    mazeGenerator.topBonusBoundary = mazeGenerator.SpawningAreaTop - mazeGenerator.SpawningAreaSize * mazeGenerator.bonusChestExtendFactor
    mazeGenerator.leftBonusBoundary = mazeGenerator.SpawningAreaLeft - mazeGenerator.SpawningAreaSize * mazeGenerator.bonusChestExtendFactor
    mazeGenerator.bonusBoundarySize = mazeGenerator.SpawningAreaSize * (1+2 *mazeGenerator.bonusChestExtendFactor)

    --Generate regularChestsBoundary specificities

    mazeGenerator.topRegularChestBoundary = mazeGenerator.SpawningAreaTop - mazeGenerator.SpawningAreaSize * mazeGenerator.regularChestsExtendFactor
    mazeGenerator.leftRegularChestBoundary = mazeGenerator.SpawningAreaLeft - mazeGenerator.SpawningAreaSize * mazeGenerator.regularChestsExtendFactor
    mazeGenerator.regularChestBoundarySize = mazeGenerator.SpawningAreaSize * (1+2 *mazeGenerator.regularChestsExtendFactor)

    --fill the grid 
    mazeGenerator.InitGrid()
    
    --start the maze!
    mazeGenerator.Explore(startingPointRow, startingPointColumn)
  end
  


function mazeGenerator.Generate()
    mazeGenerator.Initialize(2,2)
    mazeGenerator.GenerateSpawningAreaDoors()
    mazeGenerator.GenerateExit() 
    mazeGenerator.GenerateBonusChest()
    mazeGenerator.GenerateRegularChests()
end

return mazeGenerator
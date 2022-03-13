local mazeGenerator = {}

mazeGenerator.grid = {}
mazeGenerator.numberOfColumns = 0
mazeGenerator.numberOfRows = 0
local cells = 5 *3
local explored = 0
local seed = os.clock()
mazeGenerator.SpawningAreaTop = 0
mazeGenerator.SpawningAreaLeft = 0
mazeGenerator.SpawningAreaSize = 4 * 3  --doit etre un multiple de 4
local maxNumberOfTriesForDoorsBySide = 20
local extendFactor = 0.5



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
  
  function mazeGenerator.GetRowIndex(x)
    return math.floor(x / cells)
  end
  
  function mazeGenerator.GetColumnIndex(y)
    return math.floor(y / cells)
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
    for i = 1, mazeGenerator.maxNumberOfTriesForDoorsBySide do
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
    for i = 1, mazeGenerator.maxNumberOfTriesForDoorsBySide do
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
    for i = 1, mazeGenerator.maxNumberOfTriesForDoorsBySide do
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
  
  function mazeGenerator.Initialize()
    --fixe la seed rnd
    love.math.setRandomSeed(seed)
    
    mazeGenerator.grid = {}
    explored = 0
    
    mazeGenerator.numberOfColumns = math.floor(WIDTH / cells)
    mazeGenerator.numberOfRows = math.floor(HEIGHT / cells)
  
    mazeGenerator.SpawningAreaLeft = mazeGenerator.GetColumnIndex(math.floor(WIDTH / 2)) - math.floor(mazeGenerator.SpawningAreaSize / 2)
    mazeGenerator.SpawningAreaTop = mazeGenerator.GetRowIndex(math.floor(HEIGHT / 2)) - math.floor(mazeGenerator.SpawningAreaSize / 2)
    
    --Generate exitBoundary specificities
    mazeGenerator.topExitBoundary = mazeGenerator.SpawningAreaTop - mazeGenerator.SpawningAreaSize * extendFactor
    mazeGenerator.leftExitBoundary = mazeGenerator.SpawningAreaLeft - mazeGenerator.SpawningAreaSize * extendFactor
    mazeGenerator.exitBoundarySize = mazeGenerator.SpawningAreaSize * (1+2 *extendFactor)
    
    --fill the grid 
    mazeGenerator.InitGrid()
    
    --start the maze!
    mazeGenerator.Explore(2, 2)
  end
  


function mazeGenerator.Generate()
    mazeGenerator.Initialize()
    mazeGenerator.GenerateSpawningAreaDoors()
    mazeGenerator.GenerateExit() 
end

return mazeGenerator
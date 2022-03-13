
local mazeGenerator = require("maze")
function love.load()
  
  love.window.setTitle("MA7E")
  SCREEN_WIDTH = love.graphics.getWidth()
  SCREEN_HEIGHT = love.graphics.getHeight()
  
  
  mazeGenerator.Generate()
end

function love.update(dt)

end

function love.draw()
  
  for row= 1, mazeGenerator.numberOfRows do
    for column= 1, mazeGenerator.numberOfColumns do
      local cell = mazeGenerator.grid[row][column]
      
      
      if cell == "wall" then
        love.graphics.setColor(0, 0, 50)
      else
        if cell == "path" then 
          love.graphics.setColor(50, 100, 50)
        else
          if cell == "spawn" then
            love.graphics.setColor(100,0,0)
          else
            if cell == "door" then
              love.graphics.setColor(0,100,0)
            else 
              if cell == "exit" then
                love.graphics.setColor(0,0,0)
              else
                if cell == "bonusChest" then
                  love.graphics.setColor(255,215,0)
                elseif cell == "chest1" then
                  love.graphics.setColor(128,0,128)
                elseif cell == "chest2" then
                  love.graphics.setColor(255,0,0)
                elseif cell == "chest3" then
                  love.graphics.setColor(255,215,0)
                elseif cell == "chest4" then
                  love.graphics.setColor(0,255,0)
                end

                
              end
            end

          end
      
        end
      
      end
      love.graphics.rectangle("fill", (column-1)*mazeGenerator.cellSize, (row-1)*mazeGenerator.cellSize, mazeGenerator.cellSize, mazeGenerator.cellSize)
    end
  end
  
end

function love.keypressed(key, scancode, isrepeat)

  if key == "space"  then 
    mazeGenerator.Generate()

	end

end


local sprite = {}


sprite.create = function (path, quad)
   return { image = love.graphics.newImage(path), quad = quad, path=path } 
end

return sprite
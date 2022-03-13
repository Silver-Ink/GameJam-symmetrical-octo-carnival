
local sprite = {}


sprite.create = function (path, quad)
   local img = love.graphics.newImage(path)
   return { image = img, quad = quad, path = path}
end

return sprite
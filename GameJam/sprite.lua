
local sprite = {}

sprite.create_from_image = function (image, quad)
   return { image = image, quad = quad }
end

sprite.create = function (path, quad)
   local img = love.graphics.newImage(path)
   return sprite.create_from_image(img, quad)
end

return sprite
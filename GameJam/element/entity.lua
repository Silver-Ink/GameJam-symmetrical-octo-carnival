
local entity = {}

local rect = require("../rectangle")
local color = require("../color")

local dumbUid = 0

entity.create = function ()
   local e = { hitbox = rect.create(0, 0, 1, 1) }
   e.sprite = nil
   dumbUid = dumbUid+1
   e.uid = dumbUid
   return e
end

function entity:draw()
  if(self.sprite ~= nil) then
    --love.graphics.draw(self.sprite.image, self.sprite.quad, )
  end
end

return entity
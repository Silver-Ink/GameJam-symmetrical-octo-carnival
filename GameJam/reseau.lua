local reseau = {}

local button = require("button")
local rect = require("rectangle")
local color = require("color")

reseau.load = function()
  reseau.b1 = button.create(rect.create(64,64,128,128))
end

reseau.update = function(dt)

end

reseau.draw = function()
  button.draw(reseau.b1)
  --reseau.b1.draw()
end

return reseau

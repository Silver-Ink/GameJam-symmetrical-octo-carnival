local reseau = {}

local button = require("button")
local rect = require("rectangle")
local color = require("color")

reseau.load = function()
  reseau.b1 = button.create(rect.create(64,64,128,128), color.create(1, 0, 0))
  reseau.b2 = button.create(rect.create(64+256*1,64,128,128), color.create(0, 1, 0))
  print("reseaux")
end

reseau.update = function(dt)
  if button.isPress(reseau.b1) then
  print("boutton b1")
  end

  if button.isPress(reseau.b2) then
    print("boutton b2")
  end
end

reseau.draw = function()
  button.draw(reseau.b1)
  button.draw(reseau.b2)
  --reseau.b1.draw()
end

return reseau

local game = {}

local rect = require("rectangle")
local sprite = require("sprite")

game.load = function()
  game.entityBuilder = require("element.entity")
  game.entities = {}

  local test = game.entityBuilder.create()
  test.hitbox = rect.create(0, 0, 64, 64)
  test.sprite = sprite.create("Content/grass.png")
  table.insert(game.entities, test)
end

game.update = function(dt)

end

game.draw = function()
  --love.graphics.draw(ImgThomasDP)
  love.graphics.print("Game", 10, 10, 0, FONT_BIG)

  for i = 1, #game.entities do
    local e = game.entities[i]
    print(e)
    print(e.id)
    game.entityBuilder.draw(e)
  end
  --love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  --love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  --love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)
end

return game

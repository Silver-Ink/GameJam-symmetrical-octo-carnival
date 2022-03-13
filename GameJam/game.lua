local game = {}

local rect = require("rectangle")
local sprite = require("sprite")
require("gameFunc")

game.load = function()
  game.elementBuilder = require("element.element")
  game.elements = {}

  game.MAX_ELEMENT = 1000
  game.CREATE_ELEMENT_INDEX = 0

  game.camX = 0
  game.camY = 0

  for i = 1, game.MAX_ELEMENT do
    game.elements[i] = game.elementBuilder.game_true_create_do_not_use(i)
  end

  for i = 1, game.MAX_ELEMENT do
    game.elementBuilder.reset(game.elements[i])
  end
end

game.initDefaultLevel = function ()
  require("element.mapLoader").load(game)
end

game.loadLocalPlayer = function()
  require("element._loadStickman")(game, {x=3, y=3, mid = MID})
end

game.update = function(dt)

  for i = 1, game.MAX_ELEMENT do
    local e = game.elements[i]
    if(e.isUsed and e.update ~= nil) then
      e.update(e)
    end
  end
  --[[
  local camSpeed =  1/16
  if love.keyboard.isDown("right") then
    game.camX = game.camX - camSpeed
  end
  if love.keyboard.isDown("left") then
    game.camX = game.camX + camSpeed
  end

  if love.keyboard.isDown("up") then
    game.camY = game.camY + camSpeed
  end
  if love.keyboard.isDown("down") then
    game.camY = game.camY - camSpeed
  end]]

end

game.create = function (initFunction, initArguments, updateFunction, drawFunction)
  local e = game.create_empty_element()
  if(e ~= nil) then
    if(initFunction ~= nil) then
      initFunction(e, initArguments)
    end
    e.update = updateFunction or e.update
    e.draw = drawFunction or e.draw
  end
  return e
end

game.create_empty_element = function ()
  local tentative = 0
  repeat
    tentative = tentative+1
    game.CREATE_ELEMENT_INDEX = ((game.CREATE_ELEMENT_INDEX+1) % game.MAX_ELEMENT) + 1
    if(tentative > game.MAX_ELEMENT*0.8) then
      return nil
    end
  until (game.elements[game.CREATE_ELEMENT_INDEX].isUsed == false)

  game.elementBuilder.reset(game.elements[game.CREATE_ELEMENT_INDEX])
  game.elements[game.CREATE_ELEMENT_INDEX].isUsed = true
  return game.elements[game.CREATE_ELEMENT_INDEX]
end

game.deleteAt = function (index)
  game.elements[index].isUsed = false
end

game.delete = function(element)
  game.deleteAt(element.index)
end

game.draw = function()
  --love.graphics.draw(ImgThomasDP)
  love.graphics.push()
  love.graphics.scale(WIDTH/12)
  love.graphics.translate(game.camX, game.camY)

  for i = 1, game.MAX_ELEMENT do
    local e = game.elements[i]
    if(e.isUsed and e.draw ~= nil) then
      e.draw(e)
      --print(e)
      --print(e.id)
      --game.elementBuilder.draw(e)
    end
  end

  love.graphics.pop()

  love.graphics.print("Game", 10, 10, 0, FONT_BIG)

  --love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  --love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  --love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)
end

return game

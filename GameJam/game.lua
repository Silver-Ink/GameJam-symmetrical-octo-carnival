Game = {}

TICK = 0

local rect = require("rectangle")
local sprite = require("sprite")
require("gameFunc")
require("element.element")

local color = require("color")

Game.MAX_ELEMENT = 3000

local game_bg = love.graphics.newImage("Content/grass.png")

Game.load = function()
  Game.elements = {}

  Game.CREATE_ELEMENT_INDEX = 0

  Game.camX = 0
  Game.camY = 0
  TICK = 0

  for i = 1, Game.MAX_ELEMENT do
    Game.elements[i] = Element.game_true_create_do_not_use(i)
  end

  for i = 1, Game.MAX_ELEMENT do
    Element.reset(Game.elements[i])
  end
end

Game.initDefaultLevel = function ()
  require("element.mapLoader").load(Game)
end

Game.loadLocalPlayer = function()
  require("element._loadStickman")(Game, {x=3, y=3, mid = MID})
end

Game.update = function(dt)

  TICK = TICK+1
  for i = 1, Game.MAX_ELEMENT do
    local e = Game.elements[i]
    if(e.isUsed and e.update ~= nil) then
      e.update(e)
      if(e.mid == MID) then
        local coef = 0.9
        local tx, ty = -e.hitbox.x-e.hitbox.w/2, -e.hitbox.y-e.hitbox.h/2
        Game.camX = Game.camX*coef+tx*(1-coef)
        Game.camY = Game.camY*coef+ty*(1-coef)
      end
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

Game.create = function (initFunction, initArguments, updateFunction, drawFunction)
  local e = Game.create_empty_element()
  if(e ~= nil) then
    if(initFunction ~= nil) then
      initFunction(e, initArguments)
    end
    e.update = updateFunction or e.update
    e.draw = drawFunction or e.draw
  end
  return e
end

Game.create_empty_element = function ()
  local tentative = 0
  repeat
    tentative = tentative+1
    Game.CREATE_ELEMENT_INDEX = ((Game.CREATE_ELEMENT_INDEX) % (Game.MAX_ELEMENT-1)) + 1
    if(tentative > Game.MAX_ELEMENT*0.8) then
      return nil
    end
  until (Game.elements[Game.CREATE_ELEMENT_INDEX].isUsed == false)

  Element.reset(Game.elements[Game.CREATE_ELEMENT_INDEX])
  Game.elements[Game.CREATE_ELEMENT_INDEX].isUsed = true
  return Game.elements[Game.CREATE_ELEMENT_INDEX]
end

Game.deleteAt = function (index)
  Game.elements[index].isUsed = false
end

Game.delete = function(element)
  Game.deleteAt(element.index)
end

function Constraint(val, min, max)
  return math.max(math.min(val, max), min)
end

Game.draw = function()
  --love.graphics.draw(ImgThomasDP)
  love.graphics.push()
  local nbTileY = 70
  local nbTileX = math.ceil(love.graphics.getWidth()/love.graphics.getHeight()*nbTileY)
  love.graphics.scale(HEIGHT/nbTileY)

  local cX, cY = Game.camX+nbTileX/2, Game.camY+nbTileY/2
  love.graphics.translate(cX, cY)
  local addX, addY = math.ceil(cX), math.ceil(cY)

  for x = -1, nbTileX do
    for y = -1, nbTileY do
      love.graphics.draw(game_bg, x-addX, y-addY, 0, 1/128, 1/128)
    end
  end

  for i = 1, Game.MAX_ELEMENT do
    local e = Game.elements[i]
    if(e.isUsed and e.draw ~= nil) then
      e.draw(e)
      --print(e)
      --print(e.id)
    end
  end

  love.graphics.pop()

  local c = color.create(0,0,0, Constraint(math.sin(TICK/60*math.pi*2/30)*-1+0.5, 0, 1))
  color.apply(c)
  love.graphics.rectangle("fill", 0,0, WIDTH, HEIGHT)
  color.apply(color.white)

  love.graphics.print("Game", 10, 10, 0, FONT_BIG)
  love.graphics.print("M pour dessiner", 10, HEIGHT-40, 0, FONT_BIG)

  --love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  --love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  --love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)
end

return Game

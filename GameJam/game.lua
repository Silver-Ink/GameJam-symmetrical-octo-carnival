local game = {}


game.load = function()

end

game.update = function(dt)

end

game.draw = function()
  --love.graphics.draw(ImgThomasDP)
  love.graphics.print("Game", 10, 10, 0, FONT_BIG)
  --love.graphics.print("Font Big",    400, 200, 0, FONT_BIG)
  --love.graphics.print("Font Normal", 400, 300, 0, FONT_NORMAL)
  --love.graphics.print("Font Small",  400, 400, 0, FONT_SMALL)
end

return game

local t = {}

FONT_SMALL  = 0.25
FONT_NORMAL = 0.5
FONT_BIG    = 0.75

t.load = function()
  print("font start loading")
  local f = love.graphics.newFont("Content/JosefinSans-Regular.ttf", HEIGHT/10)
	love.graphics.setFont(f)
  print("font end loading")
end

return t
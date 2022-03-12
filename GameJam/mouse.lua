local mouse = {}

MOUSE_X = 0
MOUSE_Y = 0

MOUSE_IS_PRESS  = false
MOUSE_WAS_PRESS = false

mouse.update =  function()
  MOUSE_X = love.mouse.getX() / CAM_SCALE
  MOUSE_Y = love.mouse.getY() / CAM_SCALE

  MOUSE_WAS_PRESS = MOUSE_IS_PRESS
  MOUSE_IS_PRESS =  love.mouse.isDown(1)
end

return mouse
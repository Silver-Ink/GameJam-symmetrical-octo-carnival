local mouse = {}

MOUSE_X = 0
MOUSE_Y = 0

OLD_MOUSE_X = 0
OLD_MOUSE_Y = 0

WIN_MOUSE_X = 0
WIN_MOUSE_Y = 0

WIN_OLD_MOUSE_X = 0
WIN_OLD_MOUSE_Y = 0

MOUSE_IS_PRESS  = false
MOUSE_WAS_PRESS = false

mouse.update =  function()
  WIN_OLD_MOUSE_X = WIN_MOUSE_X
  WIN_OLD_MOUSE_Y = WIN_MOUSE_Y

  WIN_MOUSE_X = love.mouse.getX()
  WIN_MOUSE_Y = love.mouse.getY()

  OLD_MOUSE_X = MOUSE_X
  OLD_MOUSE_Y = MOUSE_Y

  MOUSE_X = WIN_MOUSE_X / CAM_SCALE
  MOUSE_Y = WIN_MOUSE_Y / CAM_SCALE

  MOUSE_WAS_PRESS = MOUSE_IS_PRESS
  MOUSE_IS_PRESS =  love.mouse.isDown(1)
end

return mouse
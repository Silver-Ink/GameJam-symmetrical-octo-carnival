local carte = {}

carte.Create = function ()
  local newCarte = {}
  newCarte.image = love.graphics.newCanvas()
  return newCarte
end

return carte 
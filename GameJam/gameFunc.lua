GameFunc = {}

local id = 1

local function addFunc(file)
  if(file ~= nil) then
    file = "element.logic."..file
  else file = "nil" end
  GameFunc[id]   = file
  GameFunc[file] = id
  id = id+1
end

addFunc(nil)
addFunc("elementDraw")
addFunc("stickmanUpdate")
addFunc("tileDraw")
addFunc("tileDraw2")
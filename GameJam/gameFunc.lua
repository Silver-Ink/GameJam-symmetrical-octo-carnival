GameFunc = {}

local id = 2

local function addFunc(file)
  if(file ~= nil) then
    file = "element.logic."..file
    GameFunc[id]   = file
    GameFunc[require(file)] = id
  else file = "nil" 
    GameFunc[1]   = nil
  end
  id = id+1
end

local function getFuncId(funcPtr)
  if(funcPtr == nil) then
    return 1
  end
  return GameFunc[funcPtr]
end

local function getFuncFromId(id)
  return GameFunc[id]
end

addFunc(nil)
addFunc("elementDraw")
addFunc("stickmanUpdate")
addFunc("tileDraw")
addFunc("tileDraw2")
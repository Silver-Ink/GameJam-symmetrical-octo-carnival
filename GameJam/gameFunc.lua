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

local function getFuncFromId(FuncId)
  return GameFunc[FuncId]
end


-- Lua implementation of PHP scandir function
local function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('dir "'..directory..'"')
  for filename in pfile:lines() do
      local val = filename:sub(filename:len() - 2, filename:len())
      if(val == "lua") then
        local car, ret = filename:sub(filename:len() - 3, filename:len()-2), 2
        while not (car == " ") do
          ret = ret + 1
          car = filename:sub(filename:len() - (ret+1), filename:len()-(ret+1))
        end
        i = i + 1
        t[i] = filename:sub(filename:len() - (ret), filename:len()-4)
        --print(filename:sub(filename:len() - (ret), filename:len()-4))
      end
  end
  pfile:close()
  return t, i
end

local current_dir=io.popen"cd":read'*l'

local lstFile, nbFile = scandir(current_dir .. "\\element\\logic")


for nb = 0, nbFile do
  addFunc(lstFile[nb])
end

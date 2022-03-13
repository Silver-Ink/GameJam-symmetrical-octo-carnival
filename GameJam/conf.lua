function love.conf(t)
  t.window.icon = "Content/icon.png"
end

io.stdout:setvbuf("no")
if arg[#arg] == "-debug" then require("mobdebug").start() end -- debug pas à pas

return function (elem)
  if(TICK % 10 == 0) then
    for i = 1, Game.MAX_ELEMENT do
      local e = Game.elements[i]
      if(e.isUsed and e.type == "player") then
        elem.sprite = require("sprite").create("Content/chest_red_open.png")
      end
    end
  end
end
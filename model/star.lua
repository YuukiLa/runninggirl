--[[
星星
]]
local physics = require("physics")
physics.start()
return function ()
    
    local _M = {}
    
    function _M.createStar(x, y)
        local star = display.newImage("assets/image/star.png", x, y) 
        star.myName = "star"
        physics.addBody(star, "static", {bounce = 0, friction = 0, isSensor = true})
        return star
    end
    
    return _M
    
end
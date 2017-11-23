--[[
创建地板图片的工厂类
]]
local physics = require("physics")
physics.start()

return function ()
    local _M = {}
    function _M.getLeftRoad(x, y)
        local imgRoad = display.newImage("assets/image/road_1.png", x, y) 
        physics.addBody(imgRoad, "static", {bounce = 0, friction = 0})
        return imgRoad
    end
    
    function _M.getMidRoad(x, y)
        local imgRoad = display.newImage("assets/image/road_2.png", x, y) 
        physics.addBody(imgRoad, "static", {bounce = 0, friction = 0})
        return imgRoad
    end
    
    function _M.getRightRoad(x, y)
        local imgRoad = display.newImage("assets/image/road_6.png", x, y) 
        physics.addBody(imgRoad, "static", {bounce = 0, friction = 0})
        return imgRoad
    end
    
    function _M.getFloatRoad(x, y)
        local imgRoad = display.newImage("assets/image/road_5.png", x, y) 
        physics.addBody(imgRoad, "static", {bounce = 0, friction = 0})
        return imgRoad
    end
    
    return _M
end




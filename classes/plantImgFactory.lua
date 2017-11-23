--[[
创建植物图片工厂类
]]

return function ()
    
    local _M = {}
    
    
    function _M.getTree(x, y)
        local imgPlant = display.newImage("assets/image/back_2.png", x, y) 
        return imgPlant
    end
    function _M.getMushroom(x, y)
        local imgPlant = display.newImage("assets/image/back_3.png", x, y) 
        return imgPlant
    end
    function _M.getCactus(x, y)
        local imgPlant = display.newImage("assets/image/enemy.png", x, y) 
        return imgPlant
    end
    
    
    return _M 
    
end
--[[
随机场景生成器
]]

return function()
    local road2 = require("model.road2")
    local road3 = require("model.road3")
    local road4 = require("model.road4")
    local road5 = require("model.road5")
    _M = {}
    
    function _M.getRandomScene()
        local iScaneNum = math.random(1, 4)
        local r2
        if iScaneNum == 1 then
            r2 = road3().getRoad()
        elseif iScaneNum == 2 then
            r2 = road2().getRoad()
        elseif iScaneNum == 3 then
            r2 = road4().getRoad()
        elseif iScaneNum == 4 then
            r2 = road5().getRoad()
        end
        return r2
    end
    return _M
end

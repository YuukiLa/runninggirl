--[[
分数处理
]]

local numFactory = require("classes.numImgFactory")
numFactory = numFactory()
local _M = {}

local function getNum(n)
    return numFactory.getNumberImg(tonumber(n))
end

function _M.split(num)
    num = tostring(num)
    local result = display.newGroup()
    result.x = display.contentCenterX + 52
    result.y = 25
    for i = 1, #num do
        if i >= 2 then
            local img = getNum (string.sub(num, i, i))
            img.x = result[result.numChildren].x + 22
            result:insert(img) 
        else
            result:insert(getNum (string.sub(num, i, i))) 
        end
    end
    
    return result
end

return _M



-- local function test()
--     for k, v in pairs(_M.split(245)) do
--         print(k, v)
--     end
-- end

-- test()

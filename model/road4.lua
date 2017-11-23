--[[
第四种场景
]]
local roadFactory = require("classes.roadImgFactory")
local plantFactory = require("classes.plantImgFactory")
local star = require("model.star")
roadFactory = roadFactory()
plantFactory = plantFactory()
return function ()
    
    
    local _M = {}
    
    local ipw = display.contentWidth 
    local iph = display.contentHeight
    
    function _M.getRoad()
        local group = display.newGroup()
        
        
        
        -- 背景的植物
        group:insert(plantFactory.getCactus(ipw + 108 * 3, iph - 128 * 1 - 149 + 15))
        group:insert(plantFactory.getMushroom(ipw + 108 * 17, iph - 128 * 1 - 64 + 15))
        group:insert(plantFactory.getTree(ipw + 108 * 10, iph - 128 * 4 + 15))
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 2, iph - 128 * 1))
        --中间地板
        for i = 3, 4 do
            group:insert(roadFactory.getMidRoad(ipw + 108 * i, iph - 128 * 1))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 1 - 90))
        end
        -- 右边地板
        group:insert(roadFactory.getRightRoad(ipw + 108 * 5, iph - 128 * 1))
        for i = 7, 10 do
            group:insert(roadFactory.getFloatRoad(ipw + 108 * i, iph - 128 * 2))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 3 - 90))
        end
        
        
        for i = 12, 13 do
            group:insert(roadFactory.getFloatRoad(ipw + 108 * i, iph - 128 * 3))
        end
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 16, iph - 128 * 1))
        -- 右边地板
        group:insert(roadFactory.getRightRoad(ipw + 108 * 17, iph - 128 * 1))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 18, iph - 128 * 2))
        group:insert(star().createStar(ipw + 108 * 18 + 15, iph - 128 * 2 - 90))
        
        return group
    end
    
    return _M
end
--[[
第五种场景
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
        group:insert(plantFactory.getMushroom(ipw + 108 * 4, iph - 128 * 4 - 64 + 15))
        group:insert(plantFactory.getCactus(ipw + 108 * 11, iph - 128 * 1 - 149 + 15))
        group:insert(plantFactory.getCactus(ipw + 108 * 17, iph - 128 * 2 - 149 + 15))
        
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 1, iph - 128 * 3))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 2, iph - 128 * 3))
        group:insert(star().createStar(ipw + 108 * 2 + 15, iph - 128 * 3 - 90))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 4, iph - 128 * 4))
        group:insert(star().createStar(ipw + 108 * 4 + 15, iph - 128 * 4 - 90))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 6, iph - 128 * 5))
        group:insert(star().createStar(ipw + 108 * 6 + 15, iph - 128 * 5 - 90))
        
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 9, iph - 128 * 1))
        --中间地板
        for i = 10, 13 do
            group:insert(roadFactory.getMidRoad(ipw + 108 * i, iph - 128 * 1))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 1 - 90))
        end
        -- 右边地板
        group:insert(roadFactory.getRightRoad(ipw + 108 * 14, iph - 128 * 1))
        
        
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 16, iph - 128 * 2))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 17, iph - 128 * 2))
        group:insert(star().createStar(ipw + 108 * 11 + 15, iph - 128 * 3 - 90))
        group:insert(roadFactory.getFloatRoad(ipw + 108 * 20, iph - 128 * 2))
        
        return group
    end
    
    return _M
end
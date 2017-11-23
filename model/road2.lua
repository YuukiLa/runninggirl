--[[
第二种场景
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
        group:insert(plantFactory.getTree(ipw + 108 * 3, iph - 128 * 4 + 15))
        group:insert(plantFactory.getTree(ipw + 108 * 10, iph - 128 * 4 + 15))
        group:insert(plantFactory.getCactus(ipw + 108 * 14 + 10, iph - 128 * 2 - 149 + 15))
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 2, iph - 128 * 2))
        --中间地板
        for i = 3, 5 do
            group:insert(roadFactory.getMidRoad(ipw + 108 * i, iph - 128 * 2))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 2 - 90))
        end
        -- 右边地板 
        group:insert(roadFactory.getRightRoad(ipw + 108 * 6, iph - 128 * 2))
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 8, iph - 128 * 2))
        --中间地板
        for i = 9, 11 do
            group:insert(roadFactory.getMidRoad(ipw + 108 * i, iph - 128 * 2))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 2 - 90))
        end
        -- 右边地板
        group:insert(roadFactory.getRightRoad(ipw + 108 * 12, iph - 128 * 2))
        group:insert(star().createStar(ipw + 108 * 13 + 15, iph - 128 * 3 - 90))
        
        --左边地板
        group:insert(roadFactory.getLeftRoad(ipw + 108 * 14, iph - 128 * 2))
        --中间地板
        for i = 15, 17 do
            group:insert(roadFactory.getMidRoad(ipw + 108 * i, iph - 128 * 2))
            group:insert(star().createStar(ipw + 108 * i + 15, iph - 128 * 2 - 90))
        end
        -- 右边地板
        group:insert(roadFactory.getRightRoad(ipw + 108 * 18, iph - 128 * 2))
        return group
    end
    
    return _M
end
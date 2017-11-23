--[[
第一种地形
]]
local roadFactory = require("classes.roadImgFactory")
local plantFactory = require("classes.plantImgFactory")
local star = require("model.star")
roadFactory = roadFactory()
plantFactory = plantFactory()

local _M = {}

local ipw = display.contentWidth 
local iph = display.contentHeight

function _M.getRoad()
    local group = display.newGroup()
    
    
    -- 背景的植物
    group:insert(plantFactory.getTree(100, iph - 128 * 5 + 15))
    group:insert(plantFactory.getMushroom(600, iph - 128 * 3 - 64 + 15))
    group:insert(plantFactory.getCactus(108 * 14, iph - 128 * 2 - 149 + 15))
    --左边地板
    group:insert(roadFactory.getLeftRoad(0, iph - 128 * 3))
    --中间地板
    for i = 1, 10 do
        group:insert(roadFactory.getMidRoad(108 * i, iph - 128 * 3))
    end
    -- 右边地板
    group:insert(roadFactory.getRightRoad(108 * 11, iph - 128 * 3))
    
    -- 下个页面地板
    group:insert(roadFactory.getLeftRoad(108 * 13, iph - 128 * 2))
    for i = 14, 15 do
        group:insert(roadFactory.getMidRoad(108 * i, iph - 128 * 2))
    end
    group:insert(roadFactory.getRightRoad(108 * 16, iph - 128 * 2))
    return group
    
end



return _M
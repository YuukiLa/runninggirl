--[[
全服排行精灵动画
]]
return function ()
    local options = 
    {
        width = 200, 
        height = 200, 
        numFrames = 4
    }
    local sheet = graphics.newImageSheet("assets/sprite/rank.png", options)

    local sequenceData = 
    {
        
        start = 1, count = 4, time = 500, loopCount = 0, loopDirection = "forword"
        
    }

    local rank = display.newSprite(sheet, sequenceData)
    

    return rank

end
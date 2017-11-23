--[[
小女孩在跑
]]

return function ()
    local options = 
    {
        width = 200, 
        height = 250, 
        numFrames = 8
    }
    local sheet = graphics.newImageSheet("assets/sprite/girl_run.png", options)
    
    local sequenceData = 
    {
        
        name = "running", start = 1, count = 8, time = 800, loopCount = 0, loopDirection = "forword"
        
    }
    
    local character = display.newSprite(sheet, sequenceData)
    character.x = 50
    character.y = display.contentHeight - 128 * 3 - 170
    
    return character
end
--[[
数字图片工厂
]]

return function()
    
    local _M = {}
    
    local options = 
    {
        -- Required parameters
        width = 26, 
        height = 31, 
        numFrames = 10, 
        
        -- Optional parameters; used for scaled content support
        sheetContentWidth = 260, -- width of original 1x size of entire sheet
        sheetContentHeight = 31 -- height of original 1x size of entire sheet
    }
    
    local imageSheet = graphics.newImageSheet("assets/image/shu.png", options)
    
    
    function _M.getNumberImg(num)
        local img
        if num == 1 then
            img = display.newImageRect(imageSheet, 1, 26, 31)
        elseif num == 2 then
            img = display.newImageRect(imageSheet, 2, 26, 31)
        elseif num == 3 then
            img = display.newImageRect(imageSheet, 3, 26, 31)
        elseif num == 4 then
            img = display.newImageRect(imageSheet, 4, 26, 31)
        elseif num == 5 then
            img = display.newImageRect(imageSheet, 5, 26, 31)
        elseif num == 6 then
            img = display.newImageRect(imageSheet, 6, 26, 31)
        elseif num == 7 then
            img = display.newImageRect(imageSheet, 7, 26, 31)
        elseif num == 8 then
            img = display.newImageRect(imageSheet, 8, 26, 31)
        elseif num == 9 then
            img = display.newImageRect(imageSheet, 9, 26, 31)
        elseif num == 0 then
            img = display.newImageRect(imageSheet, 10, 26, 31)
        end
        return img
    end
    return _M
end
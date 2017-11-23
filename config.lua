--
-- For more information on config.lua see the Corona SDK Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--
local normalW, normalH = 960, 640


local w, h = display.pixelWidth, display.pixelHeight
local scale = math.max(normalW / w, normalH / h)
w, h = w * scale, h * scale
application = 
{
    content = 
    {
        width = w, 
        height = h, 
        scale = "letterBox", 
        fps = 30, 
        
        --[[
imageSuffix =
{
    ["@2x"] = 2,
    ["@4x"] = 4,
},
--]]
    }, 
}

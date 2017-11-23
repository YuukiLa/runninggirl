--[[
控制声音图片的生成与切换
]]

local Sound = {} 


Sound.imgOff = display.newImage("assets/image/sound-off-A.png", display.contentWidth - 120, 60)
Sound.imgOff.isVisible = false
Sound.imgOn = display.newImage("assets/image/sound-on-A.png", display.contentWidth - 120, 60)

Sound.flag = true
Sound.callback = nil

local function imgChange()
    if Sound.flag then
        Sound.imgOff.isVisible = false
        Sound.imgOn.isVisible = true
    else
        Sound.imgOff.isVisible = true
        Sound.imgOn.isVisible = false
    end
end

function Sound:new(o) 
    o = o or {} 
    setmetatable(o, self) 
    self.__index = self 
    return o 
end 

function Sound:Instance(callback, group) 
    if self.instance == nil then 
        self.instance = self:new() 
    end 
    self.callback = callback
    group:insert(self.imgOff)
    group:insert(self.imgOn)
    imgChange()
    return self.instance 
end 




Sound.imgOn:addEventListener("tap", function(event)
    Sound.flag = false
    imgChange()
    Sound.callback({play = false})
end)
Sound.imgOff:addEventListener("tap", function(event)
    Sound.flag = true
    imgChange()
    Sound.callback({play = true})
end)
return Sound


--[[
关于
]]

local composer = require("composer")

local scene = composer.newScene()
display.setDefault("anchorX", 0.5)
display.setDefault("anchorY", 0.5)

function scene:create(event)
    local sceneGroup = self.view
    local ipw = display.contentWidth 
    local iph = display.contentHeight
    -- 图层
    local gBackGroup = display.newGroup()
    sceneGroup:insert(gBackGroup)
    -- local gUiGroup = display.newGroup()
    -- sceneGroup:insert(gUiGroup)
    -- local gMsgGroup = display.newGroup()
    -- sceneGroup:insert(gMsgGroup)

    local imgBack = display.newImage(gBackGroup, "assets/image/about_bug.jpg", display.contentCenterX, display.contentCenterY)

    imgBack:addEventListener("tap", function(event)
        transition.scaleTo(imgBack, {xScale = 5.0, yScale = 5.0, time = 3000})
        timer.performWithDelay(3000, function()
            composer.hideOverlay("fade", 400)
        end)
        
    end)


end



scene:addEventListener("create", scene)




return scene
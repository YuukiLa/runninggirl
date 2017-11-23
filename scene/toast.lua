--[[
提示信息
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
    local msg = event.params.msg


    local rectBack = display.newRoundedRect(gBackGroup, display.contentCenterX, 100, 800, 50, 20)
    rectBack:setFillColor(0.67, 0.67, 0.67, 0.5)

    local msg_ = display.newText(gBackGroup, msg, display.contentCenterX, 100, "assets/font/font1", 40)


    timer.performWithDelay(2000, function()
        composer.hideOverlay("fade", 400)
    end)

end



scene:addEventListener("create", scene)




return scene

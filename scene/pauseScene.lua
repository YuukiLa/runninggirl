--[[
暂停界面
]]

local composer = require("composer")
local score = require("data.score")
score = score:Instance()
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
    local callback = event.params.callback

    local imgBack = display.newImage(gBackGroup, "assets/image/back.png", display.contentCenterX, display.contentCenterY + 50)

    imgBack:addEventListener("tap", function(event)
        composer.hideOverlay("fade", 400)
        composer.gotoScene("scene.mainMenu", {effect = "fade", time = 500})
    end)
    local imgContinue = display.newImage(gBackGroup, "assets/image/continueA.png", display.contentCenterX, display.contentCenterY - 50)

    imgContinue:addEventListener("tap", function(event)
        callback()
        composer.hideOverlay("fade", 400)
    end)
    



end



scene:addEventListener("create", scene)




return scene
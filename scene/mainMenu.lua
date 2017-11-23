--[[
开始场景
]]
local composer = require("composer")
local sound = require("model.soundController")
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
    local gUiGroup = display.newGroup()
    sceneGroup:insert(gUiGroup)
    local gMsgGroup = display.newGroup()
    sceneGroup:insert(gMsgGroup)

    local username = score.getName()


    -- 背景
    local imgBack = display.newImage(gBackGroup, "assets/image/MainMenu.png", 0, 0)
    imgBack.anchorX = 0
    imgBack.anchorY = 0
    imgBack.width = ipw
    imgBack.height = iph
    -- 关于
    local imgAbout = display.newImage(gUiGroup, "assets/image/about.png", ipw - 201, iph - 89)
    imgAbout.anchorY = 0
    imgAbout.anchorX = 0
    imgAbout.width = 154
    imgAbout.height = 52

    imgAbout:addEventListener("tap", function(event) 
        local options = 
        {
            isModal = true, 
            effect = "fade", 
            time = 400, 
        } 
        composer.showOverlay("scene.about", options)
    end)
    
    local function soundCallback(event)
        if not event.play then
            audio.pause()
        else
            audio.resume()
        end
    end
    sound = sound:Instance(soundCallback, gUiGroup)
    
    -- 用户名
    local txtUsername = display.newText(gBackGroup, username, 100, 30, "assets/font/font1", 50)

    -- 开始
    local imgStart = display.newImage(gUiGroup, "assets/image/newgameA.png", display.contentCenterX, display.contentCenterY)
    imgStart.xScale = 2.0
    imgStart.yScale = 2.0
    local function startTapListener (event)
        composer.gotoScene("scene.game", {effect = "fade", time = 500})
    end

    imgStart:addEventListener("tap", startTapListener)

    -- rank
    local imgRank = display.newImage(gUiGroup, "assets/image/star.png", ipw - 90, display.contentCenterY)
    imgRank.width = 73
    imgRank.height = 71
    transition.scaleTo(imgRank, {xScale = 2.0, yScale = 2.0, time = 1000})
    transition.scaleTo(imgRank, {xScale = 1.0, yScale = 1.0, time = 1000, delay = 1000})
    local function scaleStarListener(event)
        transition.scaleTo(imgRank, {xScale = 2.0, yScale = 2.0, time = 1000})
        transition.scaleTo(imgRank, {xScale = 1.0, yScale = 1.0, time = 1000, delay = 1000})
    end
    local starTimer = timer.performWithDelay(2000, scaleStarListener, 0) -- 星星大大小小
    
    local function imgRank_listener(event)
        local options = 
        {
            isModal = true, 
            effect = "fade", 
            time = 400, 
        params = {username = username}} 
        composer.showOverlay("scene.ranking", options)
    end

    imgRank:addEventListener("tap", imgRank_listener)
    
    local txtRanking = display.newText(gUiGroup, "Ranking", ipw - 100, display.contentCenterY + 110, "assets/font/font1")
    txtRanking:setFillColor(0, 0.54, 1)
end







scene:addEventListener("create", scene)


return scene















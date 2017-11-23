--[[
游戏界面
]]


local composer = require ("composer")
local road = require("model.road1")
local randomScene = require("classes.randomSceneFactory")
local character = require("assets.sprite.girl_run")
local scoreFactory = require("classes.numImgFactory")
local scoreHandle = require("util.scoreHandle")
local score = require("data.score")
local sound = require("model.soundController")
local physics = require("physics")
physics.start()
physics.setGravity(0, 30)
randomScene = randomScene()
scoreFactory = scoreFactory()
score = score:Instance()
local scene = composer.newScene()
display.setDefault("anchorX", 0)
display.setDefault("anchorY", 0)
character = character()

local isJump = false
local speed = 0
local isCreateNext = true

local tTimer = {}
local tMoveTimer = {}
local gBackGroup, gUiGroup, gScoreGroup, gMsgGroup, username

local imgJump = display.newImage("assets/image/s_jump.png", 0, 0)
imgJump.alpha = 0
function scene:create(event)
    local sceneGroup = self.view
    local ipw = display.contentWidth 
    local iph = display.contentHeight
    -- 图层
    gBackGroup = display.newGroup()
    sceneGroup:insert(gBackGroup)
    gUiGroup = display.newGroup()
    sceneGroup:insert(gUiGroup)
    gScoreGroup = display.newGroup()
    sceneGroup:insert(gScoreGroup)
    gMsgGroup = display.newGroup()
    sceneGroup:insert(gMsgGroup)
    
    
    gMsgGroup:insert(imgJump)
    imgJump.myName = "jump"
    physics.addBody(imgJump, {bounce = 0, radius = 0, friction = 0})


    username = score.getName()
    -- 背景
    local imgBack = display.newImage(gBackGroup, "assets/image/back_1.png", 0, 0)
    imgBack.width = ipw
    imgBack.height = iph
    -- local imgBack = display.newImage(gBackGroup, "assets/image/back_5.png", 0, 0)
    -- imgBack.width = ipw
    -- imgBack.height = iph


    
    -- 声音控制
    local function soundCallback(event)
        if not event.play then
            audio.pause()
        else
            audio.resume()
        end
    end
    sound = sound:Instance(soundCallback, gMsgGroup)

    -- 死线
    local imgDeadLine = display.newRect(gBackGroup, 0, iph, ipw, 10)
    imgDeadLine:setFillColor(1, 0, 0, 0.01)
    imgDeadLine.myName = "die"
    physics.addBody(imgDeadLine, "static", {bounce = 0, friction = 0})
    --地板
    local r = road.getRoad()
    gUiGroup:insert(r)
    
    local imgScore = display.newImage(gScoreGroup, "assets/image/score.png", display.contentCenterX - 50, 25)
    -- local imgScoreNum = scoreFactory.getNumberImg(0)
    -- imgScoreNum.x = imgScore.x + 105
    -- imgScoreNum.y = imgScore.y
    gScoreGroup:insert(scoreHandle.split(score.getScore()))
    
    -- 角色
    
    gMsgGroup:insert(character)
    character:play()
    character.myName = "girl"
    physics.addBody(character, "dynamic", {bounce = 0, radius = 50, friction = 0})
    transition.to(character, {tag = "character", x = display.contentCenterX - 100, delay = 200, time = 3000})
    
    -- 初始场景移动
    for i = 1, r.numChildren do
        local function listener(event)
            if r[i] then
                r[i].x = r[i].x - 10
            else
                table.remove(tMoveTimer, 1)
                timer.cancel(event.source)
            end
        end
        local timerid = timer.performWithDelay(10, listener, 0)
        table.insert(tMoveTimer, timerid)
    end
    
    
    local function updateUI()
        if score.getScore() % 10 == 0 then 
            speed = speed + 1
        end
        gScoreGroup:insert(scoreHandle.split(score.getScore()))
        gScoreGroup[gScoreGroup.numChildren - 1]:removeSelf()
        gScoreGroup[gScoreGroup.numChildren - 1] = nil
    end
    
    local function die_func()
        transition.cancel()
        for i = 1, #tTimer do
            timer.cancel(tTimer[i])
        end
        for k, v in pairs(tMoveTimer) do
            timer.cancel(v)
        end
        character:pause()
        
        local imgDie = display.newImage(gMsgGroup, "assets/image/s_hurt.png", character.x, character.y)
        display.remove(character)
        display.remove(imgJump)
        character = nil
        transition.to(imgDie, {time = 500, y = iph - 400})
        transition.to(imgDie, {time = 500, y = iph - 250, delay = 500})
        
        local imgGameOver = display.newImage(gMsgGroup, "assets/image/gameover.png", display.contentCenterX, display.contentCenterY, ipw / 2, iph / 2)
        imgGameOver.alpha = 0
        imgGameOver.anchorX = 0.5
        imgGameOver.anchorY = 0.5
        transition.fadeIn(imgGameOver, {time = 500, delay = 1000})
        score.uploadScore(username)
        score.resetScore()
        imgGameOver:addEventListener("tap", function(event)
            composer.gotoScene("scene.mainMenu", {effect = "fade", time = 500, params = {username = username}})
        end)

    end

    local function jump_end()
        isJump = false 
        character.x = imgJump.x
        character.y = imgJump.y
        character.alpha = 1
        imgJump.alpha = 0 
    end


    local function collision_star(obj)
        transition.fadeOut(obj, {time = 250, delay = 50})
        score.setScore()
        updateUI()
    end
    -- 碰撞检测
    
    local function onLocalCollision(self, event)
        
        if (event.phase == "began") then
            if event.other.myName == "star" then
                timer.performWithDelay(1, function()
                    collision_star(event.other)
                end)
                
            elseif event.other.myName == "die" then
                timer.performWithDelay(1, function()
                    die_func()
                end)
            elseif event.other.myName == "jump" then
                
            else
                timer.performWithDelay(1, function()
                    if isJump then
                        jump_end()
                    end
                end)
                
            end
        end
    end



    character.collision = onLocalCollision
    character:addEventListener("collision")

    table.insert(tMoveTimer, timer.performWithDelay(1000, function()
        if not isJump then
            transition.to(character, {tag = "character", x = display.contentCenterX - 100, delay = 200, time = 3000}) 
        end
    end, 0))

    --生成下一个场景
    local function createSceneListener()
        isCreateNext = false
        
        local randomRoad = randomScene.getRandomScene()
        
        gUiGroup:insert(randomRoad)
        local j = 0
        for i = 1, randomRoad.numChildren do
            -- transition.to(r[i], {x = -400, time = 4000, delay = 3200})
            local function listener(event)
                if randomRoad[1] and i == 1 and randomRoad[1].x < 0 and j == 0 then
                    j = j + 1
                    isCreateNext = true
                end
                if randomRoad[i] then
                    randomRoad[i].x = randomRoad[i].x - (10 + speed * 1)
                else
                    table.remove(tMoveTimer, 1)
                    timer.cancel(event.source)
                end
            end
            local timerid = timer.performWithDelay(10, listener, 0)
            table.insert(tMoveTimer, timerid)
        end
        
    end

    -- 每隔100ms 检测是否需要生成新场景
    table.insert(tTimer, timer.performWithDelay(100, function (event)
        if isCreateNext then
            createSceneListener()
        end
    end, 0))

    -- 每隔5000ms 清理一次内存
    table.insert(tTimer, timer.performWithDelay(5000, function(event)
        for i = 1, gUiGroup.numChildren do
            local temp = gUiGroup[i]
            if temp.numChildren then
                -- print(type(temp.numChildren) .. ".............")
                for j = 1, temp.numChildren do
                    if temp[j] and temp[j].x < -200 then
                        temp[j]:removeSelf()
                        temp[j] = nil
                    end
                end
            end
        end
    end, 0))

end


function scene:show(event)
    -- 跳跃
    local function jumpListener(event)
        
        if (event.phase == "began") then
            if not isJump then
                if character then
                    transition.to(character, {tag = "character", time = 250, y = character.y - 250})
                    imgJump.x = character.x
                    imgJump.y = character.y
                    character.alpha = 0
                    imgJump.alpha = 1
                    transition.to(imgJump, {tag = "character", time = 250, y = character.y - 250, character.x})
                    isJump = true
                else
                    Runtime.call_back()
                end
            end
        end
    end
    Runtime:addEventListener("touch", jumpListener)
    Runtime.call_back = function()
        Runtime:removeEventListener("touch", jumpListener)
    end
    -- 暂停 
    local imgPause = display.newImage(gUiGroup, "assets/image/CloseSelected.png", 20, 20)
    --回调
    local function continue_callback()
        for i = 1, #tTimer do
            timer.resume(tTimer[i])
        end
        for k, v in pairs(tMoveTimer) do
            timer.resume(v)
        end
        transition.resume()
    end
    local function pauseListener(event)
        for i = 1, #tTimer do
            timer.pause(tTimer[i])
        end
        for k, v in pairs(tMoveTimer) do
            timer.pause(v)
        end
        transition.pause()
        local options = 
        {
            isModal = true, 
            effect = "fade", 
            time = 400, 
            params = {
                callback = continue_callback
            }} 
            composer.showOverlay("scene.pauseScene", options)
        end
        imgPause:addEventListener("tap", pauseListener)
    end


    scene:addEventListener("create", scene)
    scene:addEventListener("show", scene)


    return scene




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
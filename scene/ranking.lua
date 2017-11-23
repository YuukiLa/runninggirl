--[[
排行
]]

local composer = require("composer")
local json = require("json")
local sort = require("util.sort")
local search = require("util.search")
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
    local imgBack = display.newImage(gBackGroup, "assets/image/rank-board.png", display.contentCenterX, display.contentCenterY) 
    

    local btnBack = display.newImage(gUiGroup, "assets/image/close.png", display.contentCenterX + imgBack.width / 2 - 20, display.contentCenterY - imgBack.height / 2 + 60)
    btnBack.xScale = 0.3
    btnBack.yScale = 0.3

    btnBack:addEventListener("tap", function(event)
        composer.hideOverlay("fade", 400)
    end)

    -- local txt = display.newText(gUiGroup, "啦啦啦", display.contentCenterX, display.contentCenterY, "assets/font/font1")
    -- txt:setFillColor(0.87, 0.53, 0.01)
    local data = {}
    local function networkListener(event)
        
        if (event.isError) then
            local options = 
            {
                isModal = true, 
                effect = "fade", 
                time = 400, 
                params = {
                    msg = "网络连接超时..." 
                }} 
                composer.showOverlay("scene.toast", options)
            else
                --print(event.response)
                local data = json.decode(event.response) 
                -- print(#data)
                sort.quick_sort(data, 1, #data)
                for i = 1, 10 do
                    display.newText(gUiGroup, tostring(i), display.contentCenterX - 200, display.contentCenterY - 200 + (50 * i), "assets/font/font1"):setFillColor(0.87, 0.53, 0.01)
                    display.newText(gUiGroup, data[i].name, display.contentCenterX, display.contentCenterY - 200 + (50 * i), "assets/font/font1"):setFillColor(0.87, 0.53, 0.01)
                    display.newText(gUiGroup, data[i].score, display.contentCenterX + 180, display.contentCenterY - 200 + (50 * i), "assets/font/font1"):setFillColor(0.87, 0.53, 0.01)
                end

                local ranking = search.search(data, username)
                display.newText(gUiGroup, tostring(ranking), display.contentCenterX + 20, display.contentCenterY - 260, "assets/font/font1"):setFillColor(0.87, 0.53, 0.01)
            end

        end
        -- local headers = {}

        -- headers["Content-Type"] = "application/x-www-form-urlencoded"
        -- headers["Accept-Language"] = "zh-CN,zh;q=0.9"
        -- local body = "username="..name.. "&psw="..psw
        -- local params = {}
        -- params.headers = headers
        -- params.body = body
        
        network.request("http://127.0.0.1:3000/getall", "GET", networkListener)
        


    end







    scene:addEventListener("create", scene)

    return scene


   
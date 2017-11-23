--[[
登录界面
]]
local widget = require("widget")
local json = require("json")
local sound = require("model.soundController")
local score = require("data.score")
local user = require("data.user")
local composer = require("composer")
score = score:Instance()
user = user()
local scene = composer.newScene()
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

    -- 背景
    local imgAbout = display.newImage(gBackGroup, "assets/image/back_1.png", 0, 0)
    imgAbout.anchorY = 0
    imgAbout.anchorX = 0
    imgAbout.width = ipw
    imgAbout.height = iph
    local imgBack = display.newImage(gBackGroup, "assets/image/back_5.png", 0, 0)
    imgBack.anchorX = 0
    imgBack.anchorY = 0
    imgBack.width = ipw
    imgBack.height = iph

    --local imgSound = display.newImage(gUiGroup, "assets/image/sound-on-A.png", ipw - 120, 60)
    local function soundCallback(event)
        if not event.play then
            audio.pause()
        else
            audio.resume()
        end
    end
    sound = sound:Instance(soundCallback, gUiGroup)



    -- 创建登录框
    local loginBox = display.newContainer(gUiGroup, 800, 600)
    loginBox.x = display.contentCenterX
    loginBox.y = display.contentCenterY
    loginBox:insert(display.newRect(0, 0, 800, 600))

    -- 头部
    local login = display.newImage("assets/image/login.png", -330, -250)
    loginBox:insert(login)
    local line = display.newRect(0, -210, 800, 3)
    line:setFillColor(0, 0.54, 1)
    loginBox:insert(line)
    loginBox:insert(login)


    -- 记住密码
    local remberPsw = widget.newSwitch(
        {
            x = -220, 
            y = 130, 
            style = "checkbox", 
            id = "Checkbox"
        })
        loginBox:insert(remberPsw)
        remberPsw:setState({isOn = true})
        local txt = display.newText("记住密码", -140, 130, "assets/font/font1", 30)
        txt:setFillColor(0, 0, 0)
        
        loginBox:insert(txt)


        --按钮
        local signUp = display.newImage("assets/image/sign_up.png", -200, 200)

        loginBox:insert(signUp)
        local signIn = display.newImage("assets/image/sign_in.png", 200, 200)

        loginBox:insert(signIn)

        

        -- 用户名
        local nameLable = display.newImage(gMsgGroup, "assets/image/name.png", loginBox.x - 200, loginBox.y - 50)
        
        local nameInput = native.newTextField(loginBox.x + 50, loginBox.y - 45, 300, 60)
        gUiGroup:insert(nameInput)
        -- 密码
        local password = display.newImage(gMsgGroup, "assets/image/password.png", loginBox.x - 200, loginBox.y + 60)
        
        local passwordInput = native.newTextField(loginBox.x + 50, loginBox.y + 65, 300, 60)
        passwordInput.isSecure = true
        gUiGroup:insert(passwordInput)
        -- 尝试从文件中获取用户数据
        local tUdata = user.getUser()
        --print(#tUdata)
        if tUdata.name then
            nameInput.text = tUdata.name
            passwordInput.text = tUdata.psw
        end

        --注册回调
        local function signUpListener(event)
            local name = nameInput.text
            local psw = passwordInput.text
            if string.find(name, "%s") or string.find(psw, "%s") then 
                local options = 
                {
                    isModal = true, 
                    effect = "fade", 
                    time = 400, 
                    params = {
                        msg = "用户名或密码不能包含空格" 
                    }} 
                    composer.showOverlay("scene.toast", options)
                    -- native.showAlert("Error", "用户名或密码不能包含空格！")
                elseif name == "" or psw == "" then
                    local options = 
                    {
                        isModal = true, 
                        effect = "fade", 
                        time = 400, 
                        params = {
                            msg = "直接输入用户名密码点击注册即可完成注册" 
                        }} 
                        composer.showOverlay("scene.toast", options)
                        -- native.showAlert("hint", "直接输入用户名密码点击注册即可完成注册")
                    else
                        local function networkListener(event)
                            
                            if (event.isError) then
                                --native.showAlert("Error", "网络连接超时...")
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
                                    if event.response == "ok" then
                                        local options = 
                                        {
                                            isModal = true, 
                                            effect = "fade", 
                                            time = 400, 
                                            params = {
                                                msg = "注册成功请登录" 
                                            }} 
                                            composer.showOverlay("scene.toast", options)
                                            --native.showAlert("Ok", "注册成功请登录")
                                        elseif event.response == "exist" then
                                            local options = 
                                            {
                                                isModal = true, 
                                                effect = "fade", 
                                                time = 400, 
                                                params = {
                                                    msg = "用户名已存在" 
                                                }} 
                                                composer.showOverlay("scene.toast", options)
                                                
                                            end
                                        end
                                    end
                                    local headers = {}

                                    headers["Content-Type"] = "application/x-www-form-urlencoded"
                                    headers["Accept-Language"] = "zh-CN,zh;q=0.9"
                                    local body = "username="..name.. "&psw="..psw
                                    local params = {}
                                    params.headers = headers
                                    params.body = body
                                    
                                    network.request("http://127.0.0.1:3000/signup", "POST", networkListener, params)
                                end

                            end
                            --登录回调
                            local function signInListener(event)
                                local name = nameInput.text
                                local psw = passwordInput.text
                                if string.find(name, "%s") or string.find(psw, "%s") then 
                                    local options = 
                                    {
                                        isModal = true, 
                                        effect = "fade", 
                                        time = 400, 
                                        params = {
                                            msg = "用户名或密码不能包含空格" 
                                        }} 
                                        composer.showOverlay("scene.toast", options)
                                        --native.showAlert("Error", "用户名或密码不能包含空格！")
                                    elseif name == "" or psw == "" then
                                        local options = 
                                        {
                                            isModal = true, 
                                            effect = "fade", 
                                            time = 400, 
                                            params = {
                                                msg = "用户名密码不能为空" 
                                            }} 
                                            composer.showOverlay("scene.toast", options)
                                            --native.showAlert("hint", "用户名密码不能为空")
                                        else
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
                                                        --native.showAlert("Error", "网络连接超时...")
                                                    else
                                                        if event.response == "success" then
                                                            -- 是否勾选记住密码
                                                            if remberPsw.isOn then
                                                                local tUser = {name = name, psw = psw}
                                                                local encoded = json.encode(tUser)
                                                                user.setUser(encoded)
                                                            else
                                                                user.reset()
                                                            end


                                                            display.remove(nameInput)
                                                            display.remove(passwordInput)
                                                            score.setName(name)
                                                            composer.gotoScene("scene.mainMenu", {effect = "flipFadeOutIn", time = 500})
                                                        elseif event.response == "error" then
                                                            local options = 
                                                            {
                                                                isModal = true, 
                                                                effect = "fade", 
                                                                time = 400, 
                                                                params = {
                                                                    msg = "用户名或密码错误..." 
                                                                }} 
                                                                composer.showOverlay("scene.toast", options)
                                                                -- native.showAlert("Error", "用户名或密码错误...")
                                                            end
                                                        end
                                                    end
                                                    local headers = {}

                                                    headers["Content-Type"] = "application/x-www-form-urlencoded"
                                                    headers["Accept-Language"] = "zh-CN,zh;q=0.9"
                                                    local body = "username="..name.. "&psw="..psw
                                                    local params = {}
                                                    params.headers = headers
                                                    params.body = body
                                                    
                                                    network.request("http://127.0.0.1:3000/signin", "POST", networkListener, params)
                                                end
                                            end
                                            signUp:addEventListener("tap", signUpListener)

                                            signIn:addEventListener("tap", signInListener)
                                            
                                        end


                                        scene:addEventListener("create", scene)


                                        return scene

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                        

                                       
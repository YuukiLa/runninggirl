--[[
分数计算上传保存
]]



local _M = {}
_M.score = 0
_M.name = ""
function _M.setScore()
    _M.score = _M.score + 1
end
function _M.getScore()
    return _M.score
end
function _M.resetScore()
    _M.score = 0
end

function _M.setName(name)
    _M.name = name
end

function _M.getName()
    return _M.name
end
-- 上传分数
function _M.uploadScore(username)
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
                if event.response == "ok" then
                elseif event.response == "error" then
                    local options = 
                    {
                        isModal = true, 
                        effect = "fade", 
                        time = 400, 
                        params = {
                            msg = "error..." 
                        }} 
                        composer.showOverlay("scene.toast", options)
                        
                    end
                end
            end
            local headers = {}

            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Accept-Language"] = "zh-CN,zh;q=0.9"
            local body = "username="..username.. "&score=".._M.score
            local params = {}
            params.headers = headers
            params.body = body
            -- Access Google over SSL:
            network.request("http://127.0.0.1:3000/addscore", "POST", networkListener, params)
        end

        --TODO 保存分数到本地
        function _M.saveScore()

        end

        function _M:new(o) 
            o = o or {} 
            setmetatable(o, self) 
            self.__index = self 
            return o 
        end 

        function _M:Instance() 
            if self.instance == nil then 
                self.instance = self:new() 
            end 
            
            return self.instance 
        end

        return _M

       
--[[
管理用户信息
]]
local json = require("json")
return function ()

    local _M = {}

    local path = system.pathForFile("user.json", system.DocumentsDirectory)

    function _M.setUser(data)
        local file, errorString = io.open(path, "w")
        if not file then
            -- Error occurred; output the cause
            print("File error: " .. errorString)
        else
            
            file:write(data.."\n")
            -- Close the file handle
            io.close(file)
        end
        file = nil
    end

    function _M.getUser()
        local user = {}
        local file, errorString = io.open(path, "r")
        if not file then
            -- Error occurred; output the cause
            print("File error: " .. errorString)
        else
            
            for line in file:lines() do
                user = json.decode(line)
            end
            -- Close the file handle
            io.close(file)
        end
        file = nil
        return user
    end

    function _M.reset()
        local file, errorString = io.open(path, "w")
        if not file then
            -- Error occurred; output the cause
            print("File error: " .. errorString)
        else
            io.close(file)
        end
        file = nil
    end

    return _M

end


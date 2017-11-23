--[[
查找
]]

local _M = {}

function _M.search(tab, name)

    for i = 1, #tab do
        
        if tab[i].name == name then
            return i
        end
    end
    return - 1
end

return _M

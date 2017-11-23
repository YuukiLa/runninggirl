--[[
排序
]]

local _M = {}

local function partition(list, low, high)
    local low = low
    local high = high
    local pivotKey = list[low]

    while low < high do
        while tonumber(list[high].score) <= tonumber(pivotKey.score) and high > low do
            high = high - 1
        end

        list[low] = list[high]

        while low < high and tonumber(list[low].score) >= tonumber(pivotKey.score) do
            low = low + 1
        end

        list[high] = list[low]
    end
    list[high] = pivotKey
    return high

end

function _M.quick_sort(list, low, high)
    if low < high then
        local pivotKeyIndex = partition(list, low, high)
        _M.quick_sort(list, low, pivotKeyIndex - 1)
        _M.quick_sort(list, pivotKeyIndex + 1, high)
    end
    return list
end




return _M
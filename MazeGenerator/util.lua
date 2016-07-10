--=======================================================================
-- File Name    : util.lua
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : 2015/11/24 18:41:55
-- Description  : common function
-- Modify       :
--=======================================================================
local Util = {}

function Util.RandomPick(count, tb, save_func)
    local sort_list = {}
    local pick_list = {}
    for k, v in pairs(tb) do
        sort_list[#sort_list + 1] = save_func and save_func(k, v) or v
    end
    local length = #sort_list
    if count >= length then
        return sort_list
    end

    while count > 0 do
        local index = math.random(1, length)
        pick_list[#pick_list + 1] = sort_list[index]
        sort_list[index] = sort_list[length]
        length = length - 1
        count = count - 1
    end
    return pick_list
end

function Util.GetUnionSet()
    local set_data = {
        hash = {},
        array = {},
    }
    local Set = {}
    function Set.Add(element)
        if not set_data.hash[element] then
            table.insert(set_data.array, element)
            set_data.hash[element] = 1
            return true
        end
        return false
    end

    function Set.Remove(element)
        local index = nil
        for i, value in ipairs(set_data.array) do
            if value == element then
                index = i
                break
            end
        end
        if index then
            table.remove(set_data.array, index)
            set_data.hash[element] = nil
        end
    end

    function Set._GetHash()
        return set_data.hash
    end

     function Set._GetArray()
        return set_data.array
    end

    function Set.IsIn(element)
        return set_data.hash[element] and true or false
    end

    function Set.IsEmpty()
        return #set_data.array == 0
    end

    function Set.Count()
        return #set_data.array
    end

    function Set.Clear()
        set_data.hash = {}
        set_data.array = {}
    end

    function Set.ForEach(func)
        for _, element in ipairs(set_data.array) do
            if func(element) == 1 then
                break
            end
        end
    end

    function Set.Random()
        local r = math.random(1, #set_data.array)
        return set_data.array[r]
    end

    return Set
end

return Util

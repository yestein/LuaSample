--=======================================================================
-- File Name    : util.lua
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : 2015/11/24 18:41:55
-- Description  : common function
-- Modify       :
--=======================================================================
local Util = {}

function Util.MakeParamKey(...)
    local str = ""
    local args = {...}
    local count = select("#", ...)
    for i = 1, count do
        str = str .. tostring(args[i])
        if i ~= count then
            str = str .. "|"
        end
    end
    return str
end

function Util.Cache()
    local mem = {}
    setmetatable(mem, {__mode = "kv"})
    return mem
end
return Util

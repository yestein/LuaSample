--=======================================================================
-- File Name    : decorator.lua
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : 31/01/2017 15:51:47
-- Description  : description
-- Modify       :
--=======================================================================

local Decorator = {}

local function fn2tb(fn)
    local fn_tb = {}
    local mt = {
        __call = function(tb, ...)
            return fn(...)
        end,
    }
    setmetatable(fn_tb, mt)
    return fn_tb
end
Decorator.fn2tb = fn2tb

local function concat2call(fn_tb)
    local mt = getmetatable(fn_tb)
    mt.__concat = function(fn_tb, target_fn)
        return fn_tb(target_fn)
    end
    return fn_tb
end
Decorator.concat2call = concat2call

local function decorator(fn)
    return concat2call(fn2tb(fn))
end
Decorator.decorator = decorator

--Unit Test
if arg and arg[1] == "decorator.lua" then

end

return Decorator

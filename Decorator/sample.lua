--=======================================================================
-- File Name    : sample.lua
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : 31/01/2017 15:56:19
-- Description  : description
-- Modify       :
--=======================================================================
local Util = require "util"
local Deco = require "decorator"
local fn2tb = Deco.fn2tb
local decorator = Deco.decorator

local Sample = {}

function Sample.GetFuncTag(fn)
    local mt = getmetatable(fn)
    if not mt then
        return nil
    end
    return mt.__func_tag
end

function Sample.FuncTag(tag)
    return decorator(function(fn)
        local fn_tb = fn2tb(fn)
        local mt = getmetatable(fn_tb)
        mt.__func_tag = tag
        return fn_tb
    end)
end

function Sample.GetStatInfo(fn)
    local mt = getmetatable(fn)
    if not mt then
        return nil
    end
    return mt.__stat
end

Sample.Stat = decorator(function(fn)
    local stat = { time = 0, count = 0, }
    local ret = fn2tb(function(...)
        local old_time = os.clock()
        local result = {fn(...)}
        local new_time = os.clock()
        stat.time = stat.time + new_time - old_time
        stat.count = stat.count + 1
        return table.unpack(result)
    end)
    local mt = getmetatable(ret)
    mt.__stat = stat
    return ret
end)

Sample.Memoize = decorator(function(fn)
    local mem = {} --Util.Cache()
    local ret = fn2tb(function(...)
        local k = Util.MakeParamKey(...)
        local val = mem[k]
        if not val then
            val = {fn(...)}
            mem[k] = val
        end
        return table.unpack(val)
    end)
    ret.ClearMemory = function()
        mem = {}
    end
    return ret
end)

--Unit Test
if arg and arg[1] == "sample.lua" then
    local FuncTag = Sample.FuncTag
    local GetFuncTag = Sample.GetFuncTag


    local function foo(n) print(n) end

    local foo1 = FuncTag "foo_1" (foo)
    local foo2 = FuncTag "foo_2" (foo)

    foo1(1)                 --result: 1
    foo2(2)                 --result: 2
    print(GetFuncTag(foo1)) --result: foo_1
    print(GetFuncTag(foo2)) --result: foo_2

    local function foo(n)
        local a = 0
        for i = 1, n do
            a = a + 1
        end
        return a
    end

    local Stat = Sample.Stat
    local GetStatInfo = Sample.GetStatInfo

    local stat_foo = Stat(foo)
    for i = 1, 231 do
        stat_foo(10000)
    end
    local info = GetStatInfo(stat_foo)
    print(info.time, info.count) --result: 0.025 231

    local function foo(n)
        for i = 1, 1000000 do
            n = n + 1
        end
        print(n)
        return n
    end

    local a = Stat .. foo
    a(1)
    local b = Stat(foo)
    a(2)

    local c = FuncTag("foo1") .. foo
    c(3)
    print(GetFuncTag(c))

    local d = FuncTag("foo2")(foo)
    d(4)
    print(GetFuncTag(d))

    local e = FuncTag("foo3") .. Stat .. foo
    e(5)
    print(GetFuncTag(e))

    local f = FuncTag("foo4")(Stat(foo))
    f(6)
    print(GetFuncTag(f))


    local foo_stat =
        Stat ..
        function(n)
            for i = 1, 1000000 do
                n = n + 1
            end
            print("Real Run!") --Only Run 1 Time
            return n
        end

    local Memoize = Sample.Memoize

    local foo_final =
        FuncTag("foo_final") ..
        Memoize ..
        foo_stat

    for i = 1, 1000 do
        foo_final(1)
    end
    print(GetFuncTag(foo_final)) --result: fool_final
    print(GetStatInfo(foo_stat).time) --result: 0.008
    print(GetStatInfo(foo_stat).count) --result: 1
end

return Sample


local function GetAccumulator()
    local index = 0
    return function(start_index)
        index = index + 1
        if start_index then
            index = start_index
        end
        return index
    end
end

if arg and arg[1] == "accumulator_lua" then
    local acc1 = GetAccumulator()
    local acc2 = GetAccumulator()

    print(acc1(1))
    print(acc1())
    print(acc2(1))
    print(acc2())

    print(acc1(10))
    print(acc1())
    print(acc2(100))
    print(acc2())
end

return Accumualtor

local Accumualtor = {}

function Accumualtor:SetStartIndex(start_index)
    self.index = start_index
end

function Accumualtor:Gen(start_index)
    local result = self.index
    self.index = self.index + 1
    return result
end

if arg and arg[1] == "accumulator_cpp.lua" then
    local Class = require("class")

    local acc1 = Class.New(Accumualtor)
    local acc2 = Class.New(Accumualtor)

    acc1:SetStartIndex(1)
    acc2:SetStartIndex(1)

    print(acc1:Gen())
    print(acc1:Gen())
    print(acc2:Gen())
    print(acc2:Gen())

    acc1:SetStartIndex(10)
    acc2:SetStartIndex(100)
    print(acc1:Gen())
    print(acc1:Gen())
    print(acc2:Gen())
    print(acc2:Gen())
end

return Accumualtor

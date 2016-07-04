--C Style
local function SumArrayOdd(array)
    local result = 0
    for i, num in pairs(array) do
        if num % 2 == 1 then
            result = result + num
        end
    end
    return result
end
print(SumArrayOdd({1,2,3,4,5,6,7,8}))

local function SumArrayEven(array)
    local result = 0
    for i, num in pairs(array) do
        if num % 2 == 0 then
            result = result + num
        end
    end
    return result
end
print(SumArrayEven({1,2,3,4,5,6,7,8}))

--Lua Style
local function Accumulate(filter_func, op_func, handle_func, array)
    local result = nil
    for i, num in pairs(array) do
        if not filter_func or filter_func(num) then
            local new_num = handle_func and handle_func(num) or num
            result = op_func(result, new_num)
        end
    end
    return result
end

local function Add(a, b) return (a or 0) + b end
local function IsOdd(num) return num % 2 == 1 end
local function IsEvent(num) return num % 2 == 0 end
local function Mul(a, b) return (a or 1) * b end
local function Double(num) return num * 2 end
local function Half(num) return num / 2 end


print(Accumulate(IsOdd, Add, nil, {1,2,3,4,5,6,7,8})) --所有奇数和
print(Accumulate(IsEvent, Add, nil,  {1,2,3,4,5,6,7,8})) --所有偶数和
print(Accumulate(nil, Add, nil,  {1,2,3,4,5,6,7,8})) --所有数之和
print(Accumulate(IsOdd, Mul, nil,  {1,2,3,4,5,6,7,8})) --所有奇数乘积
print(Accumulate(IsEvent, Mul, nil,  {1,2,3,4,5,6,7,8})) --所有偶数乘积
print(Accumulate(nil, Mul, nil,  {1,2,3,4,5,6,7,8})) --所有数乘积

print(Accumulate(IsOdd, Add, Double, {1,2,3,4,5,6,7,8})) --所有奇数翻倍之后和
print(Accumulate(IsOdd, Add, Half, {1,2,3,4,5,6,7,8})) --所有奇数减半之后和






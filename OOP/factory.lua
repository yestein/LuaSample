local Man = require("man")
local Student = require("student")
local Worker = require("worker")

local function Create(kind, ...)
    if kind == "man" then
        return Man(...)
    elseif kind == "student" then
        return Student(...)
    elseif kind == "worker" then
        return Worker(...)
    end
end

--Unit Test
if arg and arg[1] == "factory" then
    local none = Create("man", "None")
    local tom = Create("student", "Tom", "0041421")
    local jim = Create("student", "Jim", "0041422")
    local simth = Create("worker", "Simith", 400)
    local hank = Create("worker", "Hank", 5000)

    none:Print()
    tom:Print()
    jim:Print()
    simth:Print()
    hank:Print()
end

return Create


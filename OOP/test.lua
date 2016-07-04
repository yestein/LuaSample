local Create = require("factory")

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

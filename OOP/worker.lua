local Class = require("class")
local Man = require("Man")

return function(name, salary)
    local _salary = salary

    local Worker = Class.New(Man(name))

    function Worker:GetSalary()
        return _salary
    end

    function Worker:SetSalary(salary)
        _salary = salary
    end

    function Worker:Print()
        print(string.format("I am Worker [%s], My Salary is %d", self:GetName(), self:GetSalary()))
    end

    return Worker
end

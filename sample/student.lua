local Class = require("class")
local Man = require("Man")

return function(name, id)
    local _id = id

    local Student = Class.New(Man(name))

    function Student:GetId()
        return _id
    end

    function Student:SetId(id)
        _id = id
    end

    function Student:Print()
        print(string.format("I am Student [%s], My Id is %d", self:GetName(), self:GetId()))
    end

    return Student
end

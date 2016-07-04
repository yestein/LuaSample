return function(name)
    local _name = name
    local Man = {}

    function Man:GetName()
        return _name
    end

    function Man:SetName(name)
        _name = name
    end

    function Man:Print()
        print(string.format("I am Man [%s]", self:GetName()))
    end
    return Man
end

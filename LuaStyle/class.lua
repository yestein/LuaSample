local Class = {}

function Class.New(base_class)

    local ret_class = {}
    setmetatable(ret_class,
        {
            __index = function(table, key)
                local v = rawget(table, key)
                if v then
                    return v
                end
                if base_class then
                    return base_class[key]
                end
            end,
        }
    )
    return ret_class
end

return Class

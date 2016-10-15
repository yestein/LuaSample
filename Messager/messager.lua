--=======================================================================
-- File Name    : co
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : coroutine
-- Description  : 18/05/2016 14:49:44
-- Modify       :
--=======================================================================

local Messager = {}

function Messager:Run(main_function, ...)
    self.co = coroutine.create(main_function)
    local result, err_msg = coroutine.resume(self.co, ...)
    if not result then
        print(err_msg)
    end
end

function Messager:Wait(wait_message)
    self.wait_message = wait_message
    print("Wait", wait_message)
    return coroutine.yield()
end

function Messager:Send(send_message, ...)
    print("Receive", send_message, ...)
    if send_message ~= self.wait_message then
        return
    end
    local result, err_msg = coroutine.resume(self.co, ...)
    if not result then
        print(err_msg)
    end
    return result
end

--Unit Test
if arg and arg[1] == "messager.lua" then
    local function Test()
        print("Start Coroutine")
        Messager:Wait("CONTINUE")
        print("Coroutine End")
    end

    print("Start Run Main Thread!")
    Messager:Run(Test)
    print("Continue Execute Main Thread")
    Messager:Send("CONTINUE")
    print("Main Thread End")
end

return Messager


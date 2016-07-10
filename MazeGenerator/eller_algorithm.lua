--=======================================================================
-- File Name    : eller_algorithm.lua
-- Creator      : yestein(yestein86@gmail.com)
-- Date         : 10/07/2016 11:26:53
-- Description  : description
-- Modify       :
--=======================================================================

local Util = require "util"

local WALL = 0
local CORRIDOR = 1

local START_ROOM = 12
local TARGET_ROOM = 13


local ICON = {
    [WALL] = '#',
    [CORRIDOR] = '.',
    [START_ROOM] = 'S',
    [TARGET_ROOM] = 'T',
}

local function XY2Index(x, y)
    return x * 10000 + y
end

local function Index2XY(index)
    return math.floor(index / 10000), index % 10000
end

local function PrintMap(data)
    for y, row in ipairs(data) do
        local str = ''
        for x, flag in ipairs(row) do
            str = str .. (ICON[flag] or 'O')
        end
        print(str)
    end
end

local function FillMaze(x, y)
    local maze_data = {
        x = x,
        y = y,
    }
    for j = 1, 2 * y + 1 do
        maze_data[j] = {}
        for i = 1, 2 * x + 1 do
            if i % 2 == 0 and j % 2 == 0 then
                maze_data[j][i] = XY2Index(i, j)
            else
                maze_data[j][i] = WALL
            end
        end
    end
    return maze_data
end

local function CanBreak(flag_a, flag_b)
    if flag_a == flag_b then
        return false
    end
    if math.random(100) > 50 then
        return false
    end
    return true
end

local function GetRowHandler(maze_data, max_x, max_y, judge_break_func)
    local function GetRoomFlag(room_x, room_y)
        return maze_data[2 * room_y][2 * room_x]
    end

    local function SetRoomFlag(room_x, room_y, flag)
        maze_data[2 * room_y][2 * room_x] = flag
    end

    local function Break(room_x_a, room_y_a, room_x_b, room_y_b)
        maze_data[room_y_a + room_y_b][room_x_a + room_x_b] = CORRIDOR
    end

    local function IsBreak(room_y, flag_a, flag_b)
        return judge_break_func(flag_a, flag_b) or (room_y == max_y and flag_a ~= flag_b)
    end

    return function(room_y)
        local set_array = {} -- Sets array at this row

        local room_2_set = {} -- Get Set Room Belongs
        for room_x = 1, max_x do
            local set = room_2_set[room_x]
            if not set then
                set = Util.GetUnionSet()
                table.insert(set_array, set)
                set.Add(XY2Index(room_x, room_y))
                room_2_set[room_x] = set
            end
            if room_x == max_x then
                break
            end

            --Break
            local flag_a = GetRoomFlag(room_x, room_y)
            local flag_b = GetRoomFlag(room_x + 1, room_y)
            local is_break = IsBreak(room_y, flag_a, flag_b)
            if is_break then
                Break(room_x, room_y, room_x + 1, room_y)
                SetRoomFlag(room_x + 1, room_y, flag_a)
                flag_b = flag_a
            end

            --Merge set
            if flag_a == flag_b then
                room_2_set[room_x + 1] = set
                set.Add(XY2Index(room_x + 1, room_y))
                SetRoomFlag(room_x + 1, room_y, flag_a)
            end
        end

        if room_y == max_y then
            return
        end

        --Down Break
        for _, set in ipairs(set_array) do
            local count = math.random(1, set.Count())
            local pick_list = Util.RandomPick(count, set._GetArray())
            for _, index in ipairs(pick_list) do
                local room_x, room_y = Index2XY(index)
                Break(room_x, room_y, room_x, room_y + 1)
                SetRoomFlag(room_x, room_y + 1, GetRoomFlag(room_x, room_y))
            end
        end
    end
end

local function EllerGen(max_x, max_y)
    local maze_data = FillMaze(max_x, max_y)
    local row_handler = GetRowHandler(maze_data, max_x, max_y, CanBreak)
    for room_y = 1, max_y do
        row_handler(room_y)
    end
    --Random Pick Start and Target
    local start_x, start_y = 1, 1
    maze_data[2 * start_y][2 * start_x] = START_ROOM
    local target_x, target_y = math.random(max_x // 2, max_x), math.random(max_y // 2, max_y)
    maze_data[2 * target_y][2 * target_x] = TARGET_ROOM
    return maze_data
end

--Unit Test
if arg and arg[1] == "eller_algorithm.lua" then
    math.randomseed(os.time())
    PrintMap(EllerGen(7, 5))
end

return EllerGen

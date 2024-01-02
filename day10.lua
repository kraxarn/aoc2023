---@class Pipe
---@field type string
---@field distance number
---@field direction string
---@field start boolean

local grid = {}

---@field type string
---@return string
function get_direction(type)
    if type == "-" then
        return "rl"
    elseif type == "|" then
        return "ud"
    elseif type == "7" then
        return "dl"
    elseif type == "J" then
        return "ul"
    elseif type == "L" then
        return "ur"
    elseif type == "F" then
        return "rd"
    end
    return ""
end

---@field direction string
---@return string
function get_type(direction)
    for ch in string.gmatch("-|7JLF", ".") do
        if get_direction(ch) == direction then
            return ch
        end
    end
    error("unknown direction: " .. direction)
    return ""
end

for line in io.lines("input/day10") do
    local row = {}
    for i = 1, #line do
        ---@type Pipe
        local pipe = {
            type = line:sub(i, i),
        }
        if pipe.type ~= "." then
            pipe.direction = get_direction(pipe.type)
        end
        row[i] = pipe
    end
    table.insert(grid, row)
end

for y = 1, #grid do
    for x = 1, #grid[y] do
        if (grid[y][x].type == "S") then
            local dir = ""

            local up = grid[y - 1][x]
            if up and string.find(get_direction(up.type), "d") then
                dir = dir .. "u"
            end

            local right = grid[y][x + 1]
            if right and string.find(get_direction(right.type), "l") then
                dir = dir .. "r"
            end

            local down = grid[y + 1][x]
            if down and string.find(get_direction(down.type), "u") then
                dir = dir .. "d"
            end

            local left = grid[y][x - 1]
            if left and string.find(get_direction(left.type), "r") then
                dir = dir .. "l"
            end

            grid[y][x].type = get_type(dir)
            grid[y][x].direction = get_direction(grid[y][x].type)
            grid[y][x].start = true
        end
    end
end

function walk(x, y, i)
    local tile = grid[y][x]
    if not tile.direction then
        return
    end
    if tile.distance ~= nil and tile.distance <= i then
        return
    end
    tile.distance = i
    for dir in string.gmatch(tile.direction, ".") do
        if dir == "u" then
            walk(x, y - 1, i + 1)
        elseif dir == "r" then
            walk(x + 1, y, i + 1)
        elseif dir == "d" then
            walk(x, y + 1, i + 1)
        elseif dir == "l" then
            walk(x - 1, y, i + 1)
        end
    end
end

for y = 1, #grid do
    for x = 1, #grid[y] do
        if grid[y][x].start then
            walk(x, y, 0)
            break
        end
    end
end

local max1 = 0

for y = 1, #grid do
    for x = 1, #grid[y] do
        local dist = grid[y][x].distance
        if dist then
            max1 = math.max(dist, max1)
        end
    end
end

print("[01] max:", max1)
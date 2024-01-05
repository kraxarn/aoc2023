---@class Position
---@field x number
---@field y number

---@class Pair
---@field from number
---@field to number

---@type string[][]
local galaxy = {}

---@field grid table
---@field y number
---@return boolean
function is_empty_row(grid, y)
    for x = 1, #grid[y] do
        if grid[y][x] ~= "." then
            return false
        end
    end
    return true
end

---@field grid table
---@field x number
---@return boolean
function is_empty_column(grid, x)
    for y = 1, #grid do
        if grid[y][x] ~= "." then
            return false
        end
    end
    return true
end

function get_distance(x1, y1, x2, y2)
    return math.abs(x1 - x2) + math.abs(y1 - y2)
end

for line in io.lines("input/day11") do
    local row = {}
    for i = 1, #line do
        row[i] = line:sub(i, i)
    end
    table.insert(galaxy, row)
end

for y = #galaxy, 1, -1 do
    if is_empty_row(galaxy, y) then
        local row = {}
        for i = 1, #galaxy[y] do
            row[i] = galaxy[y][i]
        end
        table.insert(galaxy, y, row)
    end
end

for x = #galaxy[1], 1, -1 do
    if is_empty_column(galaxy, x) then
        for y = 1, #galaxy do
            table.insert(galaxy[y], x, galaxy[y][x])
        end
    end
end

---@type Position[]
local galaxies = {}

---@type Pair[]
local pairs = {}

for y = 1, #galaxy do
    for x = 1, #galaxy[y] do
        if galaxy[y][x] == "#" then
            table.insert(galaxies, {
                x = x,
                y = y,
            })
        end
    end
end

for i = 1, #galaxies do
    for j = 1, #galaxies do
        if i < j then
            ---@type Pair
            local pair = {
                from = i,
                to = j,
            }
            table.insert(pairs, pair)
        end
    end
end

local sum1 = 0

for _, pair in ipairs(pairs) do
    local from = galaxies[pair.from]
    local to = galaxies[pair.to]
    sum1 = sum1 + get_distance(from.x, from.y, to.x, to.y)
end

print("[01] sum:", sum1)
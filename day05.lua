---@class Map
---@field source_category string
---@field destination_category string
---@field ranges Range[]

---@class Range
---@field destination_start number
---@field source_start number
---@field length number

---@param source_category string
---@return Map
function find_map(maps, source_category)
    for i = 1, #maps do
        ---@type Map
        local map = maps[i]
        if map.source_category == source_category then
            return map
        end
    end
end

---@param map Map
---@param value number
---@return Range
function find_range(map, value)
    for i = 1, #map.ranges do
        ---@type Range
        local range = map.ranges[i]
        if range.source_start < value and range.source_start + range.length > value then
            return range
        end
    end
end

local seeds = {}
local maps = {}

---@type Map
local current_map

for line in io.lines("input/day05") do
    if line:sub(0, 5) == "seeds" then
        for word in string.gmatch(line, "%S+") do
            table.insert(seeds, tonumber(word))
        end
    elseif string.find(line, "-to-") then
        if current_map then
            table.insert(maps, current_map)
        end
        current_map = {
            ranges = {},
        }
        local match = string.gmatch(line, "%w+")
        current_map.source_category = match()
        match()
        current_map.destination_category = match()
    elseif #line > 0 then
        local match = string.gmatch(line, "%d+")
        ---@type Range
        local range = {
            destination_start = tonumber(match()),
            source_start = tonumber(match()),
            length = tonumber(match()),
        }
        table.insert(current_map.ranges, range)
    end
end

table.insert(maps, current_map)

local min = math.maxinteger

for _, seed in ipairs(seeds) do
    local current = "seed"
    local value = seed
    while current ~= "location" do
        local map = find_map(maps, current)
        local range = find_range(map, value)
        if range then
            value = range.destination_start + (value - range.source_start)
        end
        current = map.destination_category
    end
    min = math.min(min, value)
end

print("[01] min:", min)
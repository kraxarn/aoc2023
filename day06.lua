---@class Race
---@field time number
---@field distance number

---@param total_time number
---@param hold_time number
---@return number
function simulate(total_time, hold_time)
    return (total_time - hold_time) * hold_time
end

---@type Race[]
local races = {}

for line in io.lines("input/day06") do
    local words = string.gmatch(line, "%w+")
    local type = words()
    for value in words do
        local num = tonumber(value)
        if type == "Time" then
            table.insert(races, { time = num })
        elseif type == "Distance" then
            for _, race in ipairs(races) do
                if not race.distance then
                    race.distance = num
                    break
                end
            end
        end
    end
end

---@type number
local sum1

for _, race in ipairs(races) do
    local count = 0
    for i = 0, race.time do
        local distance = simulate(race.time, i)
        if distance > race.distance then
            count = count + 1
        end
    end

    if sum1 then
        sum1 = sum1 * count
    else
        sum1 = count
    end
end

print("[01] sum:", sum1)
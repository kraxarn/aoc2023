---@field list number[]
---@return boolean
function is_all_zero(list)
    for i = 1, #list do
        if list[i] ~= 0 then
            return false
        end
    end
    return true
end

---@field line number[]
---@return number[]
function get_diff(list)
    local result = {}
    for i = 1, #list - 1 do
        table.insert(result, list[i + 1] - list[i])
    end
    return result
end

local sum1 = 0

for line in io.lines("input/day09") do
    local values = { {} }
    for value in string.gmatch(line, "%S+") do
        table.insert(values[1], tonumber(value))
    end

    while not is_all_zero(values[#values]) do
        table.insert(values, get_diff(values[#values]))
    end

    table.insert(values[#values], 0)

    for i = #values - 1, 1, -1 do
        local val_left = values[i][#values[i]]
        local val_below = values[i + 1][#values[i + 1]]
        table.insert(values[i], val_left + val_below)
    end

    sum1 = sum1 + values[1][#values[1]]
end

print("[01] sum:", sum1)
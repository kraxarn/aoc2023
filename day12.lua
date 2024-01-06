function get_all_arrangements(spring, result)
    for i = 1, #spring do
        if spring[i] == "?" then
            spring[i] = "."
            result = get_all_arrangements(spring, result)
            spring[i] = "#"
            result = get_all_arrangements(spring, result)
            spring[i] = "?"
            return result
        end
    end

    local combination = {}
    for _, str in ipairs(spring) do
        table.insert(combination, str)
    end

    if result == nil then
        return { combination }
    else
        table.insert(result, combination)
        return result
    end
end

function is_valid(arrangement, criteria)
    local parts = {}
    for part in string.gmatch(arrangement, "#+") do
        table.insert(parts, part)
    end
    if #parts ~= #criteria then
        return false
    end
    for i, part in ipairs(parts) do
        if #part ~= criteria[i] then
            return false
        end
    end
    return true
end

function get_all_valid(arrangements, criteria)
    local valid = {}
    for _, arrangement in ipairs(arrangements) do
        if is_valid(table.concat(arrangement, ""), criteria) then
            table.insert(valid, arrangement)
        end
    end
    return valid
end

local sum1 = 0

for line in io.lines("input/day12") do
    local parts = string.gmatch(line, "%S+")

    ---@type string[]
    local springs = {}
    for spring in string.gmatch(parts(), ".") do
        table.insert(springs, spring)
    end

    ---@type number[]
    local groups = {}
    for group in string.gmatch(parts(), "%w+") do
        table.insert(groups, tonumber(group))
    end

    local arrangements = get_all_arrangements(springs)
    local valid_arrangements = get_all_valid(arrangements, groups)
    sum1 = sum1 + #valid_arrangements
end

print("[01] sum:", sum1)
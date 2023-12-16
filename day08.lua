---@class Node
---@field name string
---@field left string
---@field right string

---@type string
local instructions
---@type Node[]
local nodes = {}

for line in io.lines("input/day08") do
    if not instructions then
        instructions = line
    elseif #line > 0 then
        local parts = string.gmatch(line, "%w+")
        ---@type Node
        local node = {
            name = parts(),
            left = parts(),
            right = parts(),
        }
        table.insert(nodes, node)
    end
end

local steps1 = 0
local current = "AAA"

while current ~= "ZZZ" do
    steps1 = steps1 + 1
    local instruction_index = ((steps1 - 1) % #instructions) + 1
    local instruction = instructions:sub(instruction_index, instruction_index)
    for _, node in ipairs(nodes) do
        if node.name == current then
            if instruction == "R" then
                current = node.right
                break
            elseif instruction == "L" then
                current = node.left
                break
            end
        end
    end
end

print("[01] steps:", steps1)
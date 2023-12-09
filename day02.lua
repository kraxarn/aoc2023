---@class Cubes
---@field red number
---@field green number
---@field blue number

---@param str string
---@param suffix string
---@return boolean
function ends_width(str, suffix)
	return str:sub(#str - #suffix, #suffix) == suffix
		or str:sub(#str - #suffix - 1, #suffix) == suffix
end

---@param str string
---@return Cubes
function get_max_count(str)
	---@type Cubes
	local result = {
		red = 0,
		green = 0,
		blue = 0,
	}

	local matches = string.gmatch(str, "%S+")
	local i = 0
	local previous
	for current in matches do
		i = i + 1
		if ends_width(current, "red") then
			result.red = math.max(result.red, tonumber(previous))
		elseif ends_width(current, "green") then
			result.green = math.max(result.green, tonumber(previous))
		elseif ends_width(current, "blue") then
			result.blue = math.max(result.blue, tonumber(previous))
		end
		previous = current
	end

	return result
end

---@param game Cubes
---@return boolean
function is_possible(game)
	return game.red <= 12 and game.green <= 13 and game.blue <= 14
end

local sum1 = 0
local sum2 = 0
local index = 0

for line in io.lines("input/day02") do
	index = index + 1
	local game = get_max_count(line)
	if is_possible(game) then
		sum1 = sum1 + index
	end
	sum2 = sum2 + game.red * game.green * game.blue
end

print("[01] sum:", sum1)
print("[02] sum:", sum2)
---@param count number
---@return number
function get_points(count)
	if count == 0 then
		return 0
	end
	local result = 1
	for i = 2, count do
		result = result * 2
	end
	return result
end

local sum1 = 0

for line in io.lines("input/day04") do
	local winning = {}
	local numbers = {}
	local current = winning
	for word in string.gmatch(line:sub(10), "%S+") do
		if word == "|" then
			current = numbers
		else
			table.insert(current, word)
		end
	end

	local count = 0
	for _, num in ipairs(numbers) do
		for _, win in ipairs(winning) do
			if num == win then
				count = count + 1
			end
		end
	end
	sum1 = sum1 + get_points(count)
end

print("[01] sum:", sum1)
---@param str string
---@return number
function find_first(str)
	for i = 1, #str do
		local result = tonumber(str:sub(i, i))
		if result then
			return result
		end
	end
end

---@param str string
---@return number
function find_last(str)
	for i = #str, 1, -1 do
		local result = tonumber(str:sub(i, i))
		if result then
			return result
		end
	end
end

local sum1 = 0

for line in io.lines("input/day01") do
	local first = find_first(line)
	local last = find_last(line)
	sum1 = sum1 + first * 10 + last
end

print("[01] sum:", sum1)
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

---@param str string
---@return number
function try_parse_str(str)
	local num = tonumber(str:sub(1, 1))
	if num then
		return num
	end

	local prefixes = {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	}

	for index, prefix in ipairs(prefixes) do
		if str:sub(1, #prefix) == prefix then
			return index
		end
	end
end

---@param str string
---@return number
function find_first_str(str)
	for i = 1, #str do
		local result = try_parse_str(str:sub(i))
		if result then
			return result
		end
	end
end

---@param str string
---@return number
function find_last_str(str)
	for i = #str, 1, -1 do
		local result = try_parse_str(str:sub(i))
		if result then
			return result
		end
	end
end

local sum1 = 0
local sum2 = 0

for line in io.lines("input/day01") do
	local first = find_first(line)
	local last = find_last(line)
	sum1 = sum1 + first * 10 + last

	local first_str = find_first_str(line)
	local last_str = find_last_str(line)
	sum2 = sum2 + first_str * 10 + last_str
end

print("[01] sum:", sum1)
print("[02] sum:", sum2)
---@param str string
---@return boolean
function is_symbol(str)
	return str and str ~= "." and not tonumber(str)
end

---@param grid table
---@param x_start number
---@param x_end number
---@param y number
---@return boolean
function any_adjacent(grid, x_start, x_end, y)
	for x = x_start, x_end do
		if y > 1 then
			if is_symbol(grid[y - 1][x - 1]) then
				return true
			end
			if is_symbol(grid[y - 1][x + 1]) then
				return true
			end
			if is_symbol(grid[y - 1][x]) then
				return true
			end
		end

		if y < #grid then
			if is_symbol(grid[y + 1][x - 1]) then
				return true
			end
			if is_symbol(grid[y + 1][x + 1]) then
				return true
			end
			if is_symbol(grid[y + 1][x]) then
				return true
			end
		end
	end

	if is_symbol(grid[y][x_start - 1]) then
		return true
	end
	if is_symbol(grid[y][x_end + 1]) then
		return true
	end

	return false
end

---@param grid table
---@param x_start number
---@param x_end number
---@param y number
---@return number
function parse_number(grid, x_start, x_end, y)
	if not any_adjacent(grid, x_start, x_end, y) then
		return 0
	end

	local str = ""
	for i = x_start, x_end do
		str = str .. grid[y][i]
	end
	return tonumber(str)
end

local sum1 = 0
local grid = {}

for line in io.lines("input/day03") do
	local row = {}
	for i = 1, #line do
		row[i] = line:sub(i, i)
	end
	table.insert(grid, row)
end

for y = 1, #grid do
	local start_index = 0
	for x = 1, #grid[y] do
		local current = grid[y][x]
		if start_index == 0 and tonumber(current) then
			start_index = x
		elseif not tonumber(current) then
			if start_index > 0 then
				sum1 = sum1 + parse_number(grid, start_index, x - 1, y)
			end
			start_index = 0
		end
	end
	if start_index > 0 then
		sum1 = sum1 + parse_number(grid, start_index, #grid[y], y)
	end
end

print("[01] sum:", sum1)
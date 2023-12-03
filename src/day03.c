#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define WIDTH 140
#define HEIGHT 140

int is_symbol(const char chr)
{
	return chr != '.' && !isdigit(chr);
}

int any_adjacent(const char grid[HEIGHT][WIDTH], const size_t x1, const size_t x2, const size_t y)
{
	for (size_t x = x1; x <= x2; x++)
	{
		if (y > 0)
		{
			if (x > 0 && is_symbol(grid[y - 1][x - 1]))
			{
				return 1;
			}

			if (x < WIDTH - 1 && is_symbol(grid[y - 1][x + 1]))
			{
				return 1;
			}

			if (is_symbol(grid[y - 1][x]))
			{
				return 1;
			}
		}

		if (y < HEIGHT - 1)
		{
			if (x > 0 && is_symbol(grid[y + 1][x - 1]))
			{
				return 1;
			}

			if (x < WIDTH - 1 && is_symbol(grid[y + 1][x + 1]))
			{
				return 1;
			}

			if (is_symbol(grid[y + 1][x]))
			{
				return 1;
			}
		}
	}

	if (x1 > 0 && is_symbol(grid[y][x1 - 1]))
	{
		return 1;
	}

	if (x2 < WIDTH - 1 && is_symbol(grid[y][x2 + 1]))
	{
		return 1;
	}

	return 0;
}

size_t parse_number(const char grid[HEIGHT][WIDTH], const size_t start, const size_t end, const size_t y)
{
	if (!any_adjacent(grid, start, end, y))
	{
		return 0;
	}

	const size_t len = end - start + 1;
	char buffer[len + 1];
	strncpy(buffer, &grid[y][start], len);
	buffer[len] = '\0';
	return atoi(buffer);
}

int main()
{
	FILE *file = fopen("input/day03", "r");

	int sum1 = 0;
	size_t i = 0;
	char schematic[HEIGHT][WIDTH] = {};

	while (fread(schematic[i++], sizeof(char), WIDTH, file) > 0)
	{
		if (i >= HEIGHT)
		{
			break;
		}

		fread(schematic[i], sizeof(char), 1, file);
	}

	fclose(file);

	for (size_t y = 0; y < HEIGHT; y++)
	{
		size_t start_index = -1;

		for (size_t x = 0; x < WIDTH; x++)
		{
			const char current = schematic[y][x];
			if (start_index == (size_t)-1 && isdigit(current))
			{
				start_index = x;
				continue;
			}

			if (!isdigit(current))
			{
				if (start_index != (size_t)-1)
				{
					sum1 += parse_number(schematic, start_index, x - 1, y);
				}

				start_index = (size_t)-1;
			}
		}

		if (start_index != (size_t)-1)
		{
			sum1 += parse_number(schematic, start_index, WIDTH - 1, y);
		}
	}

	printf("[01] sum: %i\n", sum1);
	return 0;
}

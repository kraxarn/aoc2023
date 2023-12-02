#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct cubes
{
	int red;
	int blue;
	int green;
};

int ends_width(const char *str, const char *suffix)
{
	const size_t str_len = strlen(str);
	const size_t suffix_len = strlen(suffix);

	if (strncmp(str + str_len - suffix_len, suffix, suffix_len) == 0)
	{
		return 1;
	}

	if (strncmp(str + str_len - suffix_len - 1, suffix, suffix_len) == 0)
	{
		return 1;
	}

	return 0;
}

int max(const int val1, const int val2)
{
	return val1 > val2 ? val1 : val2;
}

struct cubes get_max_count(char *str)
{
	struct cubes result = {};

	const char *previous = NULL;
	const char *current = strtok(str, " ");

	while (current != NULL)
	{
		if (ends_width(current, "red"))
		{
			result.red = max(result.red, atoi(previous));
		}
		else if (ends_width(current, "green"))
		{
			result.green = max(result.green, atoi(previous));
		}
		else if (ends_width(current, "blue"))
		{
			result.blue = max(result.blue, atoi(previous));
		}

		previous = current;
		current = strtok(NULL, " ");
	}

	return result;
}

int possible(const struct cubes *game)
{
	return game->red <= 12 && game->green <= 13 && game->blue <= 14;
}

int main()
{
	FILE *file = fopen("input/day02", "r");

	size_t index = 0;
	int sum1 = 0;
	int sum2 = 0;
	char buffer[256];

	while (fgets(buffer, sizeof(buffer), file))
	{
		index++;
		const struct cubes game = get_max_count(buffer);
		if (possible(&game))
		{
			sum1 += index;
		}

		sum2 += game.red * game.green * game.blue;
	}

	fclose(file);

	printf("[01] sum: %i\n", sum1);
	printf("[02] sum: %i\n", sum2);
	return 0;
}

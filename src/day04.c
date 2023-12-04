#include <stdio.h>
#include <stdlib.h>

#define WINNING_COUNT 10
#define NUMBERS_COUNT 25

size_t get_points(const size_t count)
{
	if (count == 0)
	{
		return 0;
	}

	size_t result = 1;

	for (size_t i = 1; i < count; i++)
	{
		result *= 2;
	}

	return result;
}

int main()
{
	FILE *file = fopen("input/day04", "r");

	int sum1 = 0;
	char buffer[128];

	int winning[WINNING_COUNT];

	while (fgets(buffer, sizeof(buffer), file))
	{
		for (size_t w = 0; w < WINNING_COUNT; w++)
		{
			const size_t index = 10 + w * 3;
			winning[w] = atoi(buffer + index);
		}

		size_t count = 0;

		for (size_t n = 0; n < NUMBERS_COUNT; n++)
		{
			const size_t index = 42 + n * 3;
			const int number = atoi(buffer + index);

			for (size_t w = 0; w < WINNING_COUNT; w++)
			{
				if (number == winning[w])
				{
					count++;
				}
			}
		}

		sum1 += get_points(count);
	}

	fclose(file);

	printf("[01] sum: %i\n", sum1);
	return 0;
}

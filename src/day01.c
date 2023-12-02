#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int try_parse(const char chr, int *result)
{
	if (chr < '0' || chr > '9')
	{
		return 0;
	}

	*result = chr - '0';
	return 1;
}

int find_first(const char *str, const size_t len)
{
	int result;

	for (int i = 0; i < len; i++)
	{
		if (try_parse(str[i], &result))
		{
			return result;
		}
	}

	return -1;
}

int find_last(const char *str, const size_t len)
{
	int result;

	for (int i = len; i >= 0; i--)
	{
		if (try_parse(str[i], &result))
		{
			return result;
		}
	}

	return -1;
}

int main()
{
	FILE *file = fopen("input/day01", "r");

	int sum = 0;
	char buffer[64];

	while (fgets(buffer, sizeof(buffer), file))
	{
		const size_t len = strlen(buffer);
		const int first = find_first(buffer, len);
		const int last = find_last(buffer, len);
		sum += first * 10 + last;
	}

	fclose(file);

	printf("[01] sum: %i", sum);
	return 0;
}

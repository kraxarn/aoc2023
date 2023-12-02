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

int try_parse_str(const char *str, int *result)
{
	if (try_parse(str[0], result))
	{
		return 1;
	}

	const char *prefixes[] = {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	};

	for (int i = 0; i < 9; i++)
	{
		const char *prefix = prefixes[i];
		if (strncmp(str, prefix, strlen(prefix)) == 0)
		{
			*result = i + 1;
			return 1;
		}
	}

	return 0;
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

int find_first_str(const char *str, const size_t len)
{
	int result;

	for (int i = 0; i < len; i++)
	{
		if (try_parse_str(str + i, &result))
		{
			return result;
		}
	}

	return -1;
}

int find_last_str(const char *str, const size_t len)
{
	int result;

	for (int i = len; i >= 0; i--)
	{
		if (try_parse_str(str + i, &result))
		{
			return result;
		}
	}

	return -1;
}

int main()
{
	FILE *file = fopen("input/day01", "r");

	int sum1 = 0;
	int sum2 = 0;
	char buffer[64];

	while (fgets(buffer, sizeof(buffer), file))
	{
		const size_t len = strlen(buffer);
		const int first = find_first(buffer, len);
		const int last = find_last(buffer, len);
		sum1 += first * 10 + last;

		const int first_str = find_first_str(buffer, len);
		const int last_str = find_last_str(buffer, len);
		sum2 += first_str * 10 + last_str;
	}

	fclose(file);

	printf("[01] sum: %i\n", sum1);
	printf("[02] sum: %i\n", sum2);
	return 0;
}

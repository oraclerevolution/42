
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

const char *LOWERCASES = "abcdefghijklmnopqrstuvwxwz";

float distance_strings(char *string1, char *string2)
{
	float distance;
	int i;
	int i2;

	i = 0;
	i2 = 0;
	distance = 0.0f;
	while (string1[i] && string2[i])
	{
		distance += string1[i] - string2[i];
		i++;
	}
	return (distance);
}

int main(int argc, char **argv)
{
	float distance;
	printf("%f\n%f", distance_strings("rome", "pope"), distance_strings("rome", "chair"));
	return (0);
}

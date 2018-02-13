/* Type: function 													 		*/
/* Function allowed: 	 													*/
/* Must create a function that outputs the exact same results as strcmp()   */

int ft_strcmp(char *s1, char *s2)
{
	int i;
	
	i = 0;
	while (s1[i] != '\0')
	{
		if (s2[i] == '\0')
			return (1);
		if (s1[i] != s2[i])
			return (s1[i] - s2[i]);
		i++;
	}
	if (s1[i] == '\0' && s2[i] != '\0')
		return (-1);

	return (0);
}

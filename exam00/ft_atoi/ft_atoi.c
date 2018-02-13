/* Type: function 													 		*/
/* Function allowed: 	 													*/
/* Must create a function that outputs the exact same results as atoi()   */

int	ft_atoi(char *src)
{
	int i;
	int result;
	int pos;
	int overflow;
	
	i = 0;
	result = 0;
	pos = 1;
	overflow = 0;
	while (src[i] == ' ' || src[i] == '\r' || src[i] == '\n' || |
			src[i] == '\v' || src[i] == '\f' || src[i] == '\t')
		i++;
	if (src[0] == '-')
	{
		pos = -1;
		i++;
	}
	while (src[i] >= '0' && src[i] <= '9')
	{
		if (pos == -1 && result == 214748364 && src[i] - '0' == 8)
			overflow = 1;
		result = (result * 10) + (src[i] - overflow - '0') ;
		i++;
	}
	return (result * pos) + (-overflow);
}

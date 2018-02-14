/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_convert_base.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/13 00:49:16 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/13 00:49:16 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

int	base_valid(char *base)
{
	int i;
	int i2;

	i = 0;
	i2 = 0;
	while (base[i] != '\0')
	{
		if (base[i] == '+' || base[i] == '-')
			return (0);
		i2 = i + 1;
		while (base[i2] != '\0')
		{
			if (base[i] == base[i2])
				return (0);
			i2++;
		}
		i++;
	}
	return (i);
}

int		get_val_frm_base(char c, char *base)
{
	int i;

	i = 0;
	while (base[i] != '\0')
	{
		if (c == base[i])
			return (i);
		i++;
	}
	return (-1);
}

char	*ft_convert_base(char *nbr, char *base_from, char *base_to)
{
	char	*tmp;
	int		ibase_len;
	int		obase_len;
	int		memsize;
	int		result;
	int		result2;
	int		i;

	ibase_len = base_valid(base_from);
	obase_len = base_valid(base_to);
	if (ibase_len <= 1 || obase_len <= 1)
		return (NULL);
	result = 0;
	i = -1;
	while (nbr[++i] != '\0')
	{
		if (get_val_frm_base(nbr[i], base_from) == -1)
			break ;
		result = result * ibase_len + get_val_frm_base(nbr[i], base_from);
	}
	i = 0;
	memsize = 0;
	result2 = result;
	while (result2 != 0 && ++memsize)
		result2 /= obase_len;
	if ((tmp = (char*)malloc(sizeof(char) * memsize + 1)) == NULL)
		return (NULL);
	tmp[memsize] = '\0';
	while (result != 0)
	{
		tmp[--memsize] = base_to[result % obase_len];
		result /= obase_len;
	}
	return (tmp);
}

int		main(void)
{
	char *test;

	test = ft_convert_base("10000101011001111001", "01", "0123456789abcdef");
	printf("%s\n", test);
	return (0);
}

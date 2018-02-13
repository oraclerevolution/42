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

int	is_base_valid(char *base)
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

char	*ft_convert_base(char *nbr, char *base_from, char *base_to)
{
	char	*tmp;
	int		ibase_len;
	int		obase_len;
	int		memsize;
	int		result;

	ibase_len = is_base_valid(base_from);
	obase_len = is_base_valid(base_to);
	if (ibase_len <= 1 || obase_len <= 1)
		return (NULL);
	memsize = 0;
	while (nbr[i] != '\0')
	{
		
	}
	

	return (tmp);
}

int		main(void)
{
	ft_convert_base("11110", "01", "0123456789");
	return (0);
}

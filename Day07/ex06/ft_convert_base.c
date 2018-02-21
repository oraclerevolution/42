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

#include <stdlib.h>

int		base_valid(char *base)
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

void	cpy_base(char *output, int nbr, char *base, int *len)
{
	int positive;

	positive = nbr >= 0 ? 0 : 1;
	if (nbr < 0)
		nbr = -nbr;
	output[len[2] + positive] = '\0';
	while (nbr != 0 + positive)
	{
		output[--len[2]] = base[nbr % len[1]];
		nbr /= len[1];
	}
	if (positive != 0)
		output[0] = '-';
}

int		get_val(int *output, char *nbr, char *base_from, int base_len)
{
	int i;
	int positive;

	i = 0;
	positive = 1;
	if (nbr[i] == '-' || nbr[i] == '+')
	{
		if (nbr[i] == '-')
			positive = -1;
		i++;
	}
	while (nbr[i] != '\0')
	{
		if (get_val_frm_base(nbr[i], base_from) == -1)
			break ;
		*output = *output * base_len + get_val_frm_base(nbr[i], base_from);
		i++;
	}
	return (positive);
}

char	*ft_convert_base(char *nbr, char *base_from, char *base_to)
{
	char	*tmp;
	int		len[3];
	int		result[2];
	int		positive;

	len[0] = base_valid(base_from);
	len[1] = base_valid(base_to);
	if (len[0] <= 1 || len[1] <= 1)
		return (NULL);
	result[0] = 0;
	positive = get_val(&result[0], nbr, base_from, len[0]);
	result[1] = result[0] * positive;
	len[2] = positive == 1 ? 0 : 1;
	while (result[1] != 0 && ++len[2])
		result[1] /= len[1];
	if ((tmp = (char*)malloc(sizeof(char) * (len[2] + 1 + \
		(positive == 1 ? 0 : 1)))) == NULL)
		return (NULL);
	cpy_base(tmp, result[0] * positive, base_to, len);
	return (tmp);
}

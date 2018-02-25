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
	output[len[2]] = '\0';
	if (nbr == 0)
		output[0] = base[0];
	while (nbr != 0)
	{
		output[--len[2]] = base[nbr % len[1]];
		nbr /= len[1];
	}
}

int		atoi_base(char *nbr, char *base_from, int base_len)
{
	int i;
	int result;

	i = 0;
	result = 0;
	while (nbr[i] != '\0')
	{
		if (get_val_frm_base(nbr[i], base_from) == -1)
			break ;
		result = result * base_len + get_val_frm_base(nbr[i], base_from);
		i++;
	}
	return (result);
}

char	*ft_convert_base(char *nbr, char *base_from, char *base_to)
{
	char	*tmp;
	int		len[3];
	int		result;
	int		tmpnbr;

	len[0] = base_valid(base_from);
	len[1] = base_valid(base_to);
	if (len[0] <= 1 || len[1] <= 1)
		return (NULL);
	result = atoi_base(nbr, base_from, len[0]);
	tmpnbr = result;
	len[2] = 0;
	while (tmpnbr != 0 && ++len[2])
		tmpnbr /= len[1];
	if ((tmp = (char*)malloc(sizeof(char) * (len[2] + 2))) == NULL)
		return (NULL);
	cpy_base(tmp, result, base_to, len);
	return (tmp);
}

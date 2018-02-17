/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_itoa.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 10:34:28 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 10:34:28 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

char	*ft_itoa(int nbr)
{
	char	*tmp;
	int		tmpnbr;
	int		size;

	tmpnbr = nbr;
	size =  nbr < 0 || nbr == 0;
	while (tmpnbr != 0)
	{
		tmpnbr /= 10;
		size++;
	}
	tmp = (char*)malloc(sizeof(char) * (size + 1));
	if (nbr < 0)
		tmp[0] = '-';
	tmp[size] = '\0';
	if (nbr == 0)
		tmp[0] = '0';
	while (nbr != 0)
	{
		tmp[--size] = '0' + (nbr >= 0 ? nbr % 10 : -nbr % 10);
		if (tmp[size] == '(')
			tmp[size] = '8';
		nbr /= 10;
	}
	return (tmp);
}

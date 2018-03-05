/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_itoa.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 20:24:58 by exam              #+#    #+#             */
/*   Updated: 2018/02/16 20:41:29 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <limits.h>

char*ft_itoa(int nbr)
{
	char *tmp;
	int tmpnbr;
	int size;
	int negative;

	negative = nbr < 0;
	tmpnbr = nbr;
	size = 1 + negative;
	while (tmpnbr != 0)
	{
		tmpnbr /= 10;
		size++;
	}
	tmp = (char*)malloc(sizeof(char) * size);
	tmp[--size] = '\0';
	tmpnbr = (nbr == INT_MIN ? 1 : 0);
	while (nbr != 0)
	{
		tmp[--size] = '0' + (negative ? -nbr : nbr) % 10;
		nbr /= 10;
	}
	if (tmpnbr)
		tmp[10] = '8';
	if (negative)
		tmp[0] = '-';
	return (tmp);
}

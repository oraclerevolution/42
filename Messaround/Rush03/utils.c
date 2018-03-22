/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   BSQ.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 15:34:03 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 15:34:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "utils.h"

void ft_putchar(char c)
{
	write(1, &c, 1);
}

void ft_print(char *str)
{
	int i;
	
	i = 0;
	while (str[i] != '\0')
		i++;
	write(1, str, i);
}

void ft_putnbr(int nbr)
{
	if (nbr > 10)
		ft_putnbr(nbr / 10);
	ft_putchar('0' + nbr % 10);
}

char* ft_strcpy(char *dest, char *src, unsigned int length)
{
	unsigned int i;
	
	i = 0;
	while (i < length)
	{
		dest[i] = src[i];
		i++;
	}
	return (dest);
}

void ft_print_colle(t_colle colle)
{
	int i;
	int margin;
	int idx;
	
	i = 6;
	margin = 0;
	idx = 0;
	while (--i != 0)
	{
		if (colle.colle & 1)
		{
			if (margin == 1)
				ft_print(" || ");
			ft_print("[colle-0");
			ft_putnbr(idx);
			ft_print("] [");
			ft_putnbr(colle.width);
			ft_print("] [");
			ft_putnbr(colle.height);
			ft_print("]");
			margin = 1;
		}
		idx++;
		colle.colle >>= 1;
	}
}
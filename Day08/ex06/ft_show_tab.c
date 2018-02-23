/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_show_tab.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/22 20:05:20 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/22 20:05:20 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_stock_par.h"
#include <stdlib.h>
#include <unistd.h>

void				ft_putstr(char *str)
{
	while (*str != '\0')
		ft_putchar(*str++);
}

void				ft_putnbr(int nb)
{
	int overflow;

	overflow = 0;
	if (nb < 0)
	{
		ft_putchar('-');
		if (nb == -2147483648)
		{
			nb = 2147483647;
			overflow = 1;
		}
		else
			nb = -nb;
	}
	if (nb >= 10)
		ft_putnbr(nb / 10);
	ft_putchar((nb % 10) + '0' + overflow);
}

void				ft_show_tab(struct s_stock_par *par)
{
	int i;
	int c;

	i = 0;
	while (par[i].str != 0)
	{
		ft_putstr(par[i].str);
		ft_putchar('\n');
		ft_putnbr(par[i].size_param);
		ft_putchar('\n');
		c = 0;
		while (par[i].tab[c] != 0)
		{
			ft_putstr(par[i].tab[c]);
			ft_putchar('\n');
			c++;
		}
		i++;
	}
}

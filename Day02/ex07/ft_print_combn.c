/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_combn.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 04:39:22 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 04:39:22 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <unistd.h>

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

int g_t;

void	print_nbr_array(int *n, int size)
{
	int i;

	i = 0;
	while (++i < size)
		if (i != 0 && n[i] <= n[i - 1])
			return ;
	i = 0;
	if (g_t == 1)
	{
		ft_putchar(',');
		ft_putchar(' ');
	}
	g_t = 1;
	while (i < size)
		ft_putchar('0' + n[i++]);
}

int		print_max_nein(void)
{
	char *str;

	str = "012345678, 012345679, 012345689, 012345789, 012346789, 012356789, \
	012456789, 013456789, 023456789, 123456789";
	while (*str)
	{
		if (*str != '\t')
			ft_putchar(*str);
		str++;
	}
	return (1);
}

void	ft_print_combn(int n)
{
	int max[2];
	int i;
	int i2;
	int i3;
	int nbrs[n];

	if (n <= 0 || n > 9 || (n == 9 && print_max_nein() == 1))
		return ;
	i = n;
	g_t = 0;
	while (i-- != 0)
		max[0] = max[0] * 10 + 9;
	while (++i <= max[0] + 1)
	{
		i2 = -1;
		while (++i2 < n)
		{
			max[1] = i;
			i3 = i2;
			while (++i3 < n)
				max[1] /= 10;
			nbrs[i2] = max[1] % 10;
			if (i2 > 0 && nbrs[i2 - 1] >= nbrs[i2])
				break ;
		}
		print_nbr_array(nbrs, n);
	}
}

int		main(void)
{
	ft_print_combn(8);
	return (1);
}

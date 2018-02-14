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

void	print_nbr_array(int *n, int size)
{
	int i;

	i = 0;
	while (++i < size)
		if(i != 0 && n[i] <= n[i - 1])
			return ;
	i = 0;
	while (i < size)
			ft_putchar('0' + n[i++]);
	
	ft_putchar(',');
	ft_putchar(' ');
}

void	ft_print_combn(int n)
{
	int max;
	int i;
	int i2;
	int i3;
	int tmp;
	int nbrs[n];
	if (n <= 0 || n > 9)
		return ;
	i = n;
	while(i-- != 0)
		max = max * 10 + 9;
	while (i <= max)
	{
		i2 = 0;
		while (i2 < n)
		{
			tmp = i;
			i3 = i2;
			while (++i3 < n)
				tmp /= 10;
			nbrs[i2] = tmp % 10;
			if (i2 > 0 && nbrs[i2 - 1] >= nbrs[i2])
				break;
			i2++;
		}
		print_nbr_array(nbrs, n);
		i++;
	}
}

int		main()
{
	ft_print_combn(9);
	return (1);
}
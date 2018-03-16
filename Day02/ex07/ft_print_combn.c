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

#include <unistd.h>

int g_t;

void	ft_putchar(char c);

int		get_max(int size)
{
	int max;
	int reverse;
	int n;

	g_t = 0;
	reverse = 0;
	n = 9;
	max = 0;
	while (size-- != 0)
		reverse = reverse * 10 + n--;
	while (reverse != 0)
	{
		max = max * 10 + reverse % 10;
		reverse /= 10;
	}
	return (max + 1);
}

int		get_min(int size)
{
	int min;
	int n;

	g_t = 0;
	n = 0;
	min = 0;
	while (size-- != 0)
		min = min * 10 + n++;
	return (min - 1);
}

void	print_nbr_array(int *n, int size)
{
	int i;

	i = 0;
	while (++i < size)
		if (n[i] <= n[i - 1])
			return ;
	if (g_t == 1)
	{
		ft_putchar(',');
		ft_putchar(' ');
	}
	else
		g_t = 1;
	i = 0;
	while (i < size)
		ft_putchar('0' + n[i++]);
}

void	ft_print_combn(int n)
{
	int max;
	int i;
	int i2;
	int tmp;
	int nbrs[n];

	if (n <= 0 || n > 9 || (max = get_max(n)) == -1)
		return ;
	i = get_min(n);
	while (++i < max)
	{
		i2 = n;
		tmp = i;
		while (i2-- != 0)
		{
			nbrs[i2] = tmp % 10;
			if (i2 != n - 1 && nbrs[i2] >= nbrs[i2 + 1])
				break ;
			tmp /= 10;
		}
		if (i2 == -1)
			print_nbr_array(nbrs, n);
	}
}

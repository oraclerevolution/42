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

void	ft_putchar(char c);

int		ft_putstr(void)
{
	int		i;
	char	*str;

	str = "012345678, 012345679, 012345689, 012345789, 012346789, \
	012356789, 012456789, 013456789, 023456789, 123456789";
	i = -1;
	while (str[++i])
		if (str[i] != '\t')
			ft_putchar(str[i]);
	return (-1);
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

int		get_max(int size)
{
	int max;
	int reverse;
	int n;

	if (size == 9)
		return (ft_putstr());
	g_t = 0;
	reverse = 0;
	n = 9;
	max = 0;
	while (size-- != 0)
		reverse = reverse * 10 + n--;
	while (reverse > 0)
	{
		max = max * 10 + reverse % 10;
		reverse /= 10;
	}
	return (max + 1);
}

void	ft_print_combn(int n)
{
	int max[2];
	int i;
	int i2;
	int i3;
	int nbrs[n];

	if (n <= 0 || n > 9 || (max[0] = get_max(n)) == -1)
		return ;
	i = -1;
	while (++i < max[0])
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

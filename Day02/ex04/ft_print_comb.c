/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_comb.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/08 00:06:01 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/08 00:06:01 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putchar(char c);

void	ft_print_comb(void)
{
	int		i;
	char	a;
	char	b;
	char	c;

	i = 011;
	while (i++ < 789)
	{
		a = i / 100;
		b = i % 100 / 10;
		c = (i % 10) % 10;
		if (a < b && b < c)
		{
			ft_putchar('0' + a);
			ft_putchar('0' + b);
			ft_putchar('0' + c);
			if (a != 7)
			{
				ft_putchar(',');
				ft_putchar(' ');
			}
		}
	}
}

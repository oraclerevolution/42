/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_comb2.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 23:50:16 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/07 23:50:16 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putchar(char c);

void	ft_print_comb2(void)
{
	int		a;
	char	u;
	char	d;

	a = 0;
	while (a++ < 9899)
	{
		u = a / 100;
		d = a % 100;
		if (u < d)
		{
			if (a != 1)
			{
				ft_putchar(',');
				ft_putchar(' ');
			}
			ft_putchar('0' + u / 10);
			ft_putchar('0' + u % 10);
			ft_putchar(' ');
			ft_putchar('0' + d / 10);
			ft_putchar('0' + d % 10);
		}
	}
}

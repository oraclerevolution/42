/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tab_mult.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/02 11:19:03 by exam              #+#    #+#             */
/*   Updated: 2018/03/02 11:30:17 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int ft_atoi(char *str)
{
	int result;
	int i;

	result = 0;
	i = 0;
	while (str[i] && (str[i] == ' ' || str[i] == '\t' || str[i] == '\n'))
		   i++;
	while (str[i] >= '0' && str[i] <= '9')
		result = result * 10 + str[i++] - '0';
	return (result);
}

void ft_putchar(char c)
{
	write(1, &c, 1);
}

void ft_putnbr(int nbr)
{
	if (nbr >= 10)
		ft_putnbr(nbr / 10);
	ft_putchar('0' + (nbr % 10));
}

int main(int argc, char **argv)
{
	int nbr;
	int mul;

	if (argc == 1)
	{
		write(1, "\n", 1);
		return (0);
	}
	mul = 1;
	nbr = ft_atoi(argv[1]);
	while (mul <= 9)
	{
		ft_putchar('0' + mul);
		write(1, " x ", 3);
		ft_putnbr(nbr);
		write(1, " = ", 3);
		ft_putnbr(mul++ * nbr);
		ft_putchar('\n');
	}
	return (0);
}

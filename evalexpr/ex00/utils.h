/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   utils.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 23:32:09 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 23:32:09 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef UTILS_H
# define UTILS_H
# include <unistd.h>

int		ft_atoi(char *str);
int		is_operator(char c);
int		count_operators(char *str);
int		count_nbrs(char *str);
void	ft_putchar(char c);
void	ft_putnbr(int nb);


int	is_operator(char c)
{
	return (c == '+' || c == '-' || c == '%' || c == '/' || c == '*');
}

int	count_operators(char *str)
{
	int count;
	int i;

	count = 0;
	while (str[i] != '\0')
	{
		if (is_operator(str[i]))
			count++;
		i++;
	}
	return (count);
}

int	count_nbrs(char *str)
{
	int count;
	int i;

	count = 0;
	while (str[i] != '\0')
	{
		if (0)
			count++;
		i++;
	}
	return (count);
}

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

void	ft_putnbr(int nb)
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

int	ft_atoi(char *str)
{
	int pos;
	int i;
	int result;

	i = 0;
	result = 0;
	pos = 1;
	while (str[i] == ' ' || str[i] == '\n' || str[i] == '\f' || \
			str[i] == '\t' || str[i] == '\v' || str[i] == '\r')
		i++;
	if (str[i] == '-' || str[i] == '+')
		if (str[i++] == '-')
			pos = -1;
	while (str[i] >= '0' && str[i] <= '9')
		result = result * 10 + str[i++] - '0';
	return (result * pos);
}

#endif
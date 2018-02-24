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

int		ft_atoi(char *str, int *end);
int		is_operator(char c);
void	ft_putchar(char c);
void	ft_putnbr(int nb);

char *remove_spaces(char *str)
{
	int i;
	int w;
	int count;

	i = 0;
	count = 0;
	while (str[i] != '\0')
	{
		if (str[i] == ' ')
		{
			w = i + 1;
			while (str[w] != '\0')
			{
				str[w - 1] = str[w];
				w++;
			}
		}
		else
			count++;
		i++;
	}
	str[count] = '\0';
	return (str);
}

char *get_operators(char *str)
{
	char	*tmp;
	int		i;
	int		count;

	tmp = NULL;
	i = -1;
	count = 1;
	while (str[++i])
	{
		if (is_operator(str[i]))
			count++;
	}
	if ((tmp = (char*)malloc(sizeof(char) * count)) == NULL)
		return (NULL);
	i = -1;
	count = 0;
	while (str[++i])
		if (is_operator(str[i]))
			tmp[count++] = str[i];
	return (tmp);
}

int *get_numbers(char *str, int *length)
{
	int		*tmp;
	int		i;
	int		tabsize;

	tmp = NULL;
	i = 0;
	tabsize = 1;
	while (str[i] != '\0')
	{
		while (str[i] >= '0' && str[i] <= '9')
		{
			tabsize++;
			i++;
		}
		if (str[i] != '\0')
			i++;
	}
	tmp = (int*)malloc(sizeof(int) * (tabsize));
	i = 0;
	tabsize = 0;
	while (str[i] != '\0')
	{
		if (str[i] >= '0' && str[i] <= '9')
		{
			tmp[tabsize++] = ft_atoi(str + i, &i);
		}
		if (str[i] != '\0')
			i++;
	}
	*length = tabsize;
	return (tmp);
}

int	is_operator(char c)
{
	return (c == '+' || c == '-' || c == '%' || c == '/' || c == '*' || c == '(' || c == ')');
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

int	ft_atoi(char *str, int *end)
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
	*end += i;
	return (result * pos);
}

#endif
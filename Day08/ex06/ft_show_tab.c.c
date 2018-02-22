/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_show_tab.c.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 04:35:12 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 04:35:12 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_stock_par.h"
#include <stdlib.h>
#include <unistd.h>

void ft_putchar(char c)
{
	write(1, &c, 1);
}

void ft_putstr(char *str)
{
	while (*str != '\0')
		ft_putchar(*str++);
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


int			find_next_word(char *str)
{
	int i;

	i = 0;
	while (str[i] && (str[i] != ' ' && str[i] != '\t' && str[i] != '\n'))
		i++;
	return (i - 1);
}

int			count_words(char *str)
{
	int count;
	int i;

	count = 0;
	i = 0;
	while (str[i])
	{
		if (str[i] != ' ' & str[i] != '\t' & str[i] != '\n')
		{
			i = i + find_next_word(str + i);
			count++;
		}
		i++;
	}
	return (count);
}

void		cpy_word(char *dest, char *src, int length)
{
	int i;

	i = 0;
	while (src[i] && i < length)
	{
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	return ;
}

char		**ft_split_whitespaces(char *str)
{
	char	**tmp;
	int		i;
	int		c;
	int		last;

	c = 0;
	i = 0;
	if ((tmp = (char**)malloc(sizeof(char*) * (count_words(str) + 1))) == NULL)
		return (NULL);
	while (str[i])
	{
		if (str[i] != ' ' & str[i] != '\t' & str[i] != '\n')
		{
			last = i;
			i += find_next_word(str + i);
			if ((tmp[c] = (char*)malloc(sizeof(char) * (i - last))) == NULL)
				return (NULL);
			cpy_word(tmp[c++], str + last, i - last + 1);
		}
		i++;
	}
	if ((tmp[c] = (char*)malloc(sizeof(char))) == NULL)
		return (NULL);
	tmp[c] = 0;
	return (tmp);
}

struct s_stock_par *ft_param_to_tab(int ac, char **av);

void ft_show_tab(struct s_stock_par *par)
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

int main(int argc, char **argv)
{
	struct s_stock_par* t = ft_param_to_tab(argc, argv);
	ft_show_tab(t);
}
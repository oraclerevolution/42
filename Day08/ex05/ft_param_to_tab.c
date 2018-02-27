/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_param_to_tab.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/22 19:59:04 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/22 19:59:04 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_stock_par.h"
#include <stdlib.h>

char				*ft_strdup2(char *src, int *length)
{
	int		i;
	char	*tmp;

	i = 1;
	while (src[i] != '\0')
		i++;
	*length = i;
	if ((tmp = (char*)malloc(sizeof(char) * (i))) == NULL)
		return (NULL);
	while (--i >= 0)
		tmp[i] = src[i];
	return (tmp);
}

struct s_stock_par	*ft_param_to_tab(int ac, char **av)
{
	t_stock_par *tmp;

	if ((tmp = (t_stock_par*)malloc(sizeof(t_stock_par) * (ac + 1))) == NULL)
		return (NULL);
	tmp[ac].str = 0;
	while (--ac >= 0)
	{
		tmp[ac].str = av[ac];
		tmp[ac].copy = ft_strdup2(av[ac], &tmp[ac].size_param);
		tmp[ac].tab = ft_split_whitespaces(av[ac]);
	}
	return (tmp);
}

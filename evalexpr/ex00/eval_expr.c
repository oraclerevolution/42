/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   eval_expr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 23:20:34 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 23:20:34 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "utils.h"
#include <stdlib.h>

int eval_expr(char *str)
{
	int		result;
	int		i;
	int		*nbrs;
	char	*operators;

	if ((operators = (char*)malloc(sizeof(char) * count_operators(str))) == NULL)
		return (0);
	if ((nbrs = (int*)malloc(sizeof(int) * count_nbrs(str))) == NULL)
		return (0);
	result = 0;
	i = 0;
	while (str[i] != '\0')
	{

		i++;
	}
	return (result);
}

int main(int ac, char **av)
{
	if (ac > 1)
	{
		ft_putnbr(eval_expr(av[1]));
		ft_putchar('\n');
	}
	return (0);
}
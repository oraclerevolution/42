/* ***********************remove_spaces*************************************************** */
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
	int result;
	int	i;
	char operator;

	result = 0;
	i = 0;
	operator = '\0';
	remove_spaces(str);
	while (str[i] != '\0')
	{
		if (operator == '\0')
		{
			if (is_operator(str[i]))
				operator = str[i];
			result += ft_atoi(str + i, &i);
			continue;
		}
		else
		{
			result = calc(result, ft_atoi(str + i, &i), str[i]);
			operator = '\0';
		}
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
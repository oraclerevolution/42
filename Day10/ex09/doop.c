/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   do-op.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/24 19:50:02 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/24 19:50:02 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include "ft_opp.h"
#include "utils.h"

int		print(char *str);
int		ft_putnbr(int nb);
int		ft_atoi(char *str);

void	get_op_and_nbr(char **av, int *nbr1, int *nbr2, char *operator)
{
	*nbr1 = ft_atoi(av[1]);
	*nbr2 = ft_atoi(av[3]);
	*operator = av[2][0];
}

int		main(int argc, char **argv)
{
	int		nbr[2];
	int		result;
	char	operator;

	if (argc != 4)
		return (0);
	result = 0;
	get_op_and_nbr(argv, &nbr[0], &nbr[1], &operator);
	if (operator == '-')
		return (ft_putnbr(nbr[0] - nbr[1]));
	if (operator == '+')
		return (ft_putnbr(nbr[0] + nbr[1]));
	if (operator == '/')
	{
		if (nbr[0] == 0 || nbr[1] == 0)
			return (print("Stop : division by zero\n"));
		return (ft_putnbr(nbr[0] / nbr[1]));
	}
	if (operator == '%')
	{
		if (nbr[0] == 0 || nbr[1] == 0)
			return (print("Stop : modulo by zero\n"));
		return (ft_putnbr(nbr[0] / nbr[1]));
	}
	return (ft_putnbr(0));
}

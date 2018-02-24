/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/24 21:24:31 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/24 21:24:31 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		print(char *str);
int		ft_putnbr(int nb);
int		ft_atoi(char *str);
int		ft_add(int nbr1, int nbr2);
int		ft_sub(int nbr1, int nbr2);
int		ft_mul(int nbr1, int nbr2);
int		ft_div(int nbr1, int nbr2);
int		ft_mod(int nbr1, int nbr2);

#include "ft_opp.h"

void	get_nbrs(char **av, int *nbr1, int *nbr2)
{
	*nbr1 = ft_atoi(av[1]);
	*nbr2 = ft_atoi(av[3]);
}

int main(int argc, char **argv)
{
	int		nbr[2];
	int		result;

	if (argc != 4)
		return (0);
	get_nbrs(argv, &nbr[0], &nbr[1]);
	result = 0;
	return (0);
}
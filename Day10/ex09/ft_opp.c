/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_opp.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/24 21:05:25 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/24 21:05:25 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_opp.h"
#include "ut.h"

int		ft_add(int nbr, int nbr2)
{
	return (nbr + nbr2);
}

int		ft_sub(int nbr, int nbr2)
{
	return (nbr - nbr2);
}

int		ft_mul(int nbr, int nbr2)
{
	return (nbr * nbr2);
}

int		ft_div(int nbr, int nbr2)
{
	return (nbr / nbr2);
}

int		ft_mod(int nbr, int nbr2)
{
	return (nbr % nbr2);
}

void	ft_usage()
{
	return ;
}

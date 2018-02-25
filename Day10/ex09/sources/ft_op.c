/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_op.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/24 23:01:30 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/24 23:01:33 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putnbr(int nb);
void	print(char *str);

void	ft_add(int nbr1, int nbr2)
{
	ft_putnbr(nbr1 + nbr2);
}

void	ft_sub(int nbr1, int nbr2)
{
	ft_putnbr(nbr1 - nbr2);
}

void	ft_mul(int nbr1, int nbr2)
{
	ft_putnbr(nbr1 * nbr2);
}

void	ft_div(int nbr1, int nbr2)
{
	if (nbr1 == 0 || nbr2 == 0)
		print("Stop : division by zero");
	else
		ft_putnbr(nbr1 / nbr2);
}

void	ft_mod(int nbr1, int nbr2)
{
	if (nbr1 == 0 || nbr2 == 0)
		print("Stop : modulo by zero");
	else
		ft_putnbr(nbr1 % nbr2);
}

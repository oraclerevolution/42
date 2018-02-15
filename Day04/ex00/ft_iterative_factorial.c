/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_iterative_factorial.c                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 22:51:26 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 11:28:53 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_iterative_factorial(int nb)
{
	int result;

	if (nb < 0 || nb > 12)
		return (0);
	if (nb <= 1)
		return (1);
	result = 1;
	while (nb != 1)
	{
		result *= nb;
		nb--;
	}
	return (result);
}

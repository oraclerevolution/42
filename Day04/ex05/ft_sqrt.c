/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sqrt.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 22:52:59 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/07 22:52:59 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_sqrt(int nb)
{
	int result;

	result = 1;
	if (nb == 0)
		return (0);
	while (result * result < nb)
		result++;
	if (nb % result == 0 && result * result == nb)
		return (result);
	return (0);
}

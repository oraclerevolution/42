/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_active_bits.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 11:32:25 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 11:32:26 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

unsigned int	ft_active_bits(int value)
{
	int count;

	if (value < 0)
		value++;
	else if (value == 0)
		return (0);
	count = 0;
	while (value != 0)
	{
		count += value % 2;
		value /= 2;
	}
	return (count > 0 ? count : 32 + count);
}

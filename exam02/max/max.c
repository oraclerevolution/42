/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   max.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 20:43:42 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/26 20:43:43 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		max(int *tab, unsigned int len)
{
	int max;
	unsigned int i;

	if (len == 0)
		return (0);
	max = tab[0];
	i = 0;
	while (++i < len)
		if (tab[i] > max)
			max = tab[i];
	return (max)
}

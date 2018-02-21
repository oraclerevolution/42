/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_range.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 10:19:38 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 10:19:39 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int	*ft_range(int min, int max)
{
	int *tmp;
	int i;

	if (min >= max)
		return (NULL);
	if (max - min > 1)
		max--;
	i = -1;
	tmp = malloc(sizeof(int) * (max - min));
	while (++i <= (max - min))
		tmp[i] = i + min;
	return (tmp);
}

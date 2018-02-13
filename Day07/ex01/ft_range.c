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
		return (int*)NULL;
	i = 0;
	tmp = (int*)malloc(sizeof(int) * (max - min));
	while (i <= (max - min))
	{
		tmp[i] = i + min;
		i++;
	}
	return (tmp);
}

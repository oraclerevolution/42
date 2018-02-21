/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_ultimate_range.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 10:26:09 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 10:26:09 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int	ft_ultimate_range(int **range, int min, int max)
{
	int *tmp;
	int i;

	*range = NULL;
	i = -1;
	if (min >= (max) || (tmp = (int*)malloc(sizeof(int) * (max - min))) == NULL)
		return (0);
	while (++i < (max - min))
		tmp[i] = i + min;
	*range = tmp;
	return (i);
}

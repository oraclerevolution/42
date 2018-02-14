/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_map.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 17:56:02 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 17:56:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int	*ft_map(int *tab, int length, int (*f)(int))
{
	int *tmp;
	int i;

	if ((tmp = (int*)malloc(sizeof(int) * length)) == NULL)
		return (NULL);
	i = -1;
	while (++i < length)
		tmp[i] = (*f)(tab[i]);
	return (tmp);
}

/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_destroy.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/15 23:48:50 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/15 23:48:51 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "ft_ultimator.h"

void	ft_destroy(char ***factory)
{
	int a;
	int b;

	a = 0;
	while (factory[a] != NULL)
	{
		b = 0;
		while (factory[a][b] != NULL)
		{
			free(factory[a][b]);
			b++;
		}
		free(factory[a++]);
	}
	free(factory);
}

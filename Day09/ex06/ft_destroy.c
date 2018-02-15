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
#include <stdio.h>
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

int		main(void)
{
	char	***str;
	int		i;
	int		i2;
	int		size;

	size = 5;
	i = 0;
	str = (char***)malloc(sizeof(char*) * size);
	while (i < size - 1)
	{
		str[i] = (char**)malloc(sizeof(char) * size);
		i2 = 0;
		while (i2 < size - 1)
		{
			str[i][i2] = (char*)malloc(sizeof(char) * size);
			i2++;
		}
		str[i][size - 1] = NULL;
		i++;
	}
	str[size - 1] = NULL;
	ft_destroy(str);
	return (0);
}

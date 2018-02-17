/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 09:54:05 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 09:54:06 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

char	*ft_strdup(char *src)
{
	int		i;
	char	*tmp;

	i = 0;
	while (src[i] != '\0')
		i++;
	tmp = (char*)malloc(sizeof(char) * (i + 1));
	while (i >= 0)
	{
		tmp[i] = src[i];
		i--;
	}
	return (tmp);
}

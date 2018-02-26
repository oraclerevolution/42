/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   utils.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 23:32:09 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 23:32:09 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef UTILS_H
# define UTILS_H
# include <unistd.h>

char	*remove_spaces(char *str)
{
	int i;
	int w;
	int count;

	i = 0;
	count = 0;
	while (str[i] != '\0')
	{
		if (str[i] == ' ')
		{
			w = i + 1;
			while (str[w] != '\0')
			{
				str[w - 1] = str[w];
				w++;
			}
		}
		else
			count++;
		i++;
	}
	str[count] = '\0';
	return (str);
}

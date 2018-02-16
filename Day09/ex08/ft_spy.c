/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_spy.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 03:17:13 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 03:17:14 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdio.h>

int	k_strfind(char *str, char *to_find)
{
	int i;
	int n;

	i = 0;
	while (str[i] == ' ' || str[i] == '\t')
		i++;
	if (str[i] != '\0')
	{
		n = 0;
		while ((str[i + n] == to_find[n] || \
			str[i + n] == to_find[n] - 32) && to_find[n] != '\0')
			n++;
		if (to_find[n] == '\0')
			return (1);
	}
	return (0);
}

int	main(int argc, char **argv)
{
	int i;
	int found;

	found = 0;
	i = 1;
	while (i < argc && !found)
	{
		if (k_strfind(argv[i], "president"))
			found = 1;
		if (k_strfind(argv[i], "attack"))
			found = 1;
		if (k_strfind(argv[i], "bauer"))
			found = 1;
		i++;
	}
	if (found)
		write(1, "Alert!!!\n", 9);
	return (0);
}

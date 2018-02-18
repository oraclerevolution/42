/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_concat_params.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 14:22:07 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 14:22:07 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int		get_argv_total_length(int argc, char **argv)
{
	int length;
	int n;
	int i;

	n = 1;
	i = 0;
	length = 0;
	while (n < argc)
	{
		i = 0;
		while (argv[n][i] != '\0')
		{
			i++;
			length++;
		}
		length++;
		n++;
	}
	return (length - 1);
}

char	*ft_concat_params(int argc, char **argv)
{
	char	*tmp;
	int		n;
	int		i;
	int		offset;

	n = get_argv_total_length(argc, argv);
	tmp = (char*)malloc(sizeof(char) * (n + 1));
	n = 1;
	offset = 0;
	while (n < argc)
	{
		i = 0;
		while (argv[n][i] != '\0')
		{
			tmp[offset + i] = argv[n][i];
			i++;
		}
		tmp[offset + i] = '\n';
		offset += i + 1;
		n++;
	}
	tmp[offset] = '\0';
	return (tmp);
}

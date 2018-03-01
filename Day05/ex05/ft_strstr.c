/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strstr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/09 04:24:55 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/09 04:24:56 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

char	*ft_strstr(char *str, char *to_find)
{
	int i;
	int n;

	i = 0;
	while (str[i] != 0)
	{
		if (str[i] != to_find[0] && i++)
			continue;
		n = 1;
		while (str[i + n] == to_find[n] && to_find[n] != '\0')
			n++;
		if (to_find[n] == '\0')
			return (str + i);
		i++;
	}
	return ((void*)0);
}

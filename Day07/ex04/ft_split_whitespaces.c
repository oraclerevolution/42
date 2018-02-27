/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split_whitespaces.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/12 05:54:26 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/12 05:54:27 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int			find_next_word(char *str)
{
	int i;

	i = 0;
	while (str[i] && (str[i] != ' ' && str[i] != '\t' && str[i] != '\n'))
		i++;
	return (i - 1);
}

int			count_words(char *str)
{
	int count;
	int i;

	count = 0;
	i = 0;
	while (str[i])
	{
		if (str[i] != ' ' & str[i] != '\t' & str[i] != '\n')
		{
			i = i + find_next_word(str + i);
			count++;
		}
		i++;
	}
	return (count);
}

void		cpy_word(char *dest, char *src, int length)
{
	int i;

	i = 0;
	while (src[i] && i < length)
	{
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	return ;
}

char		**ft_split_whitespaces(char *str)
{
	char	**tmp;
	int		i;
	int		c;
	int		last;

	c = 0;
	i = 0;
	if ((tmp = (char**)malloc(sizeof(char*) * (count_words(str) + 1))) == NULL)
		return (NULL);
	while (str[i])
	{
		if (str[i] != ' ' & str[i] != '\t' & str[i] != '\n')
		{
			last = i;
			i += find_next_word(str + i);
			if ((tmp[c] = (char*)malloc(sizeof(char) * (i - last))) == NULL)
				return (NULL);
			cpy_word(tmp[c++], str + last, i - last + 1);
		}
		i++;
	}
	tmp[c] = 0;
	return (tmp);
}

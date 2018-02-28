/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/13 01:36:21 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/13 01:36:21 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

int			is_separator(char c, char *charset)
{
	int i;

	i = 0;
	while (charset[i])
	{
		if (charset[i++] == c)
			return (1);
	}
	return (0);
}

int			find_next_word(char *str, char *charset)
{
	int i;

	i = 0;
	while (str[i])
	{
		if (is_separator(str[i], charset))
			return (i);
		i++;
	}
	return (i - 1);
}

int			c_w(char *str, char *charset)
{
	int count;
	int i;
	int b;

	count = 0;
	i = 0;
	while (str[i])
	{
		b = 0;
		if (!is_separator(str[i], charset))
		{
			i = i + find_next_word(str + i, charset);
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

char		**ft_split(char *str, char *charset)
{
	char	**tmp;
	int		i;
	int		c;
	int		last;

	c = 0;
	i = -1;
	if ((tmp = (char**)malloc(sizeof(char*) * (c_w(str, charset) + 1))) == NULL)
		return (NULL);
	while (str[++i])
		if (!is_separator(str[i], charset))
		{
			last = i;
			i += find_next_word(str + i, charset);
			if ((tmp[c] = (char*)malloc(sizeof(char) * (i - last + 1))) == NULL)
				return (NULL);
			cpy_word(tmp[c++], str + last, i - last + \
				(is_separator(str[last + (i - last)], charset) ? 0 : 1));
		}
	tmp[c] = 0;
	return (tmp);
}

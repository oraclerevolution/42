/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_utils.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:28:19 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/27 01:56:25 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"
#include <unistd.h>

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

char	*ft_strdup2(char *src, int maxlength)
{
	int		i;
	char	*tmp;

	if (maxlength <= 0)
		return (NULL);
	i = 0;
	tmp = (char*)malloc(sizeof(char) * (maxlength + 1));
	while (i >= 0)
	{
		tmp[i] = src[i];
		i--;
	}
	tmp[maxlength] = '\0';
	return (tmp);
}

int		ft_atoi(char *str, int *index, int maxsize)
{
	int pos;
	int i;
	int result;

	i = 0;
	result = 0;
	pos = 1;
	while (i < maxsize && (str[i] == ' ' || str[i] == '\n' || \
		str[i] == '\f' || str[i] == '\t' || str[i] == '\v' || str[i] == '\r'))
		i++;
	if (str[i] == '-' || str[i] == '+')
		if (str[i++] == '-')
			pos = -1;
	while (i < maxsize && str[i] >= '0' && str[i] <= '9')
		result = result * 10 + str[i++] - '0';
	if (index != NULL)
		*index += i;
	return (result * pos);
}

int		ft_print(char *str)
{
	int i;

	i = 0;
	while (str[i])
		i++;
	write(1, str, i);
	return (0);
}

char	*ft_concat_strings(char **dest, char *src, int size)
{
	char	*tmp;
	int		i;
	int		dest_len;

	if (size <= 0 || dest == NULL || *dest == NULL)
		return (*dest);
	dest_len = 0;
	while ((*dest)[dest_len])
		dest_len++;
	tmp = (char*)malloc(sizeof(char) * (dest_len + size + 1));
	i = -1;
	while (++i < dest_len)
		tmp[i] = (*dest)[i];
	i = -1;
	while (++i < size)
		tmp[dest_len + i] = src[i];
	tmp[dest_len + i] = '\0';
	free(*dest);
	return (tmp);
}

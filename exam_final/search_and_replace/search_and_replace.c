/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   search_and_replace.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/02 10:29:30 by exam              #+#    #+#             */
/*   Updated: 2018/03/02 10:39:30 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int main(int argc, char **argv)
{
	int i;
	int i2;
	char *str;
	char *to_find;
	char *replacement;

	if (argc != 4)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	str = argv[1];
	to_find = argv[2];
	replacement = argv[3];
	while (str[i])
	{
		i2 = 0;
		while (to_find[i2] != '\0' && to_find[i2] == str[i + i2])
			i2++;
		if (to_find[i2] == '\0')
		{
			i += i2;
			i2 = 0;
			while (replacement[i2])
				i2++;
			write(1, replacement, i2);
		}
		else
			write(1, str + i++, 1);
	}
	write(1, "\n", 1);
	return (0);
}

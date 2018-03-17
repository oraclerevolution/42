/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rstr_capitalizer.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/02 10:54:39 by exam              #+#    #+#             */
/*   Updated: 2018/03/02 11:17:03 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

char toMin(char c)
{
	if (c >= 'A' && c <= 'Z')
		return (c + ('a' - 'A'));
	return (c);
}

char toMaj(char c)
{
    if (c >= 'a' && c <= 'z')
		return (c - ('a' - 'A'));
    return (c);
}

char is_letter(char c)
{
	return ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'));
}

char is_separator(char c)
{
	return (c == ' ' || c == '\t');
}

int rstr_capitalizer(char *str)
{
	int i;

	i = 0;
	while (str[i])
	{
		while (str[i] && !is_separator(str[i]))
		{
			str[i] = toMin(str[i]);
			i++;
		}
		if (i != 0)
			str[i - 1] = toMaj(str[i - 1]);
		if (str[i] != '\0')
			i++;
	}
	return (i);
}

int main(int argc, char **argv)
{
	int i;
	int str_len;

	if (argc == 1)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 1;
	while (i < argc)
	{
		str_len = rstr_capitalizer(argv[i]);
		write(1, argv[i], str_len);
		write(1, "\n", 1);
		i++;
	}
	return (0);
}

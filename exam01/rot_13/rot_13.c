/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rot_13.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 18:20:54 by exam              #+#    #+#             */
/*   Updated: 2018/02/16 18:46:17 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int is_letter(char c)
{
	return ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'));
}

char get_new_letter(char c)
{
	if (c >= 'a' && c <= 'z')
	{
		if (c <= 'z' - 13)
			return (c + 13);
		return ('a' + (12 - ('z' - c)));
	}
	if (c <= 'Z' - 13)
		return (c + 13);
	return ('A' + (12 - ('Z' - c )));
}

int main(int argc, char **argv)
{
	int i;

	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	while (argv[1][i] != '\0')
	{
		if (is_letter(argv[1][i]))
		{
			argv[1][i] = get_new_letter(argv[1][i]);
			write(1, &argv[1][i], 1);
		}
		else
			write(1, &argv[1][i], 1);
		i++;
	}
	write(1, "\n", 1);
	return (0);
}

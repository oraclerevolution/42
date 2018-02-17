/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   last_word.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 10:52:45 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 10:52:45 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdio.h>

char	is_separator(char c)
{
	if (c == ' ' || c == '\t')
		return (1);
	return (0);
}

int		get_word_length(char *str, int start)
{
	int i;

	i = start;
	while (i != -1 && !is_separator(str[i]))
	{
		i--;
	}
	return (start - i);
}

int main(int argc, char **argv)
{
	int i;
	int end;
	int word_length;

	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	end = 0;
	while (argv[1][end] != '\0')
		end++;
	while (end != 0)
	{
		if (!is_separator(argv[1][end]) && ((word_length = get_word_length(argv[1], end)) > 1))
			break;
		end--;
	}
	write(1, argv[1] + (end - word_length + 1), word_length);
	write(1, "\n", 1);
	return 0;
}

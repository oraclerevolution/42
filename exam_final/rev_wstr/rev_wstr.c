/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rev_wstr.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/02 11:38:01 by exam              #+#    #+#             */
/*   Updated: 2018/03/02 12:38:30 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <unistd.h>

char is_separator(char c)
{
	return (c == ' ' || c == '\t');
}

int get_word_start(char *str, int end)
{
	while (end > 0 && !is_separator(str[end]))
		end--;
	return (end);
}

void print_trim_spaces(char *str)
{
	int start;
	int i;

	start = 0;
	while (is_separator(str[start]))
		start++;
	i = start;
	while (str[start + i] != '\0' && !is_separator(str[start + i]))
		i++;
	write(1, str + start, i);
}

int main(int argc, char **argv)
{
	int i;
	int start;

	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	while (argv[1][i] != '\0')
		i++;
	while (--i > 0)
	{
		if (!is_separator(argv[1][i]))
		{
			start = get_word_start(argv[1], i);
			print_trim_spaces(argv[1] + start);
			i = start;
			while (start != 0 && !is_separator(argv[1][start]))
				start--;
			if (is_separator(argv[1][start]))
				write(1, " ", 1);
		}
	}
	write(1, "\n", 2);
	return (0);
}

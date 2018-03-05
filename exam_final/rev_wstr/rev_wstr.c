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

int g_dirty;

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

void print_trim_spaces(char *str, int len)
{
	int start;
	int i;

	start = 0;
	while (is_separator(str[start]))
		start++;
	while (len >= 0 && str[len] > 0 && is_separator(str[len]) && (g_dirty = 1) == 1)
		len--;
	i = -1;
	while (++i < len)
		if(str[i] >= 32)
			write(1, str + start + i, 1);
}

int main(int argc, char **argv)
{
	int i;
	int i2;

	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	g_dirty = 0;
	while (argv[1][i])
		i++;
	while (i-- > 0)
	{
		if (is_separator(argv[1][i]))
			continue;
		i2 = get_word_start(argv[1], i);
		print_trim_spaces(argv[1] + i2, i - i2 + 1);
		i = i2;
		if (i - 1 > 0)
			write(1, " ", 1);
	}
	if (g_dirty)
	{
		while (!is_separator(argv[1][i]))
			i++;
		write(1, argv[1] + i - 1, 1);
	}
	write(1, "\n", 1);
	return (0);
}

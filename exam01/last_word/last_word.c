/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   last_word.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 18:52:03 by exam              #+#    #+#             */
/*   Updated: 2018/02/16 19:33:04 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int main(int argc, char **argv)
{
	int i;
	int end;
	int charcount;
	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	while (argv[1][i] != '\0')
		i++;
	i -= 1;
	while (i > 0 && (argv[1][i] == ' ' || argv[1][i] == '\t'))
		i--;
	argv[1][i + 1] = '\0';
	end = i + 1;
	while (i > 0 && (argv[1][i] != ' ' &&  argv[1][i] != '\t'))
		i--;
	while (argv[1][i+1] == ' ' || argv[1][i+1]== '\t')
		i++;
	if (end - i > 1)
		write(1, i == 0 ? argv[1] : argv[1] + i + 1, end - i);
	write(1, "\n", 1);
	return (0);
}

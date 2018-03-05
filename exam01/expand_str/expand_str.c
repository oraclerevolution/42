/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   expand_str.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 19:50:24 by exam              #+#    #+#             */
/*   Updated: 2018/02/16 19:56:34 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

int main(int argc, char **argv)
{
	int i;
	int start;
	int end;

	if (argc != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	i = 0;
	while (argv[1][i] == ' ' || argv[1][i] == '\t')
		i++;
	start = i;
	while (argv[1][i] != '\0')
		i++;
	while (argv[1][i] == ' ' || argv[1][i] == '\t')
		i--;
	end = i + 1;
	write(1, argv[1] + start, end - start);
	write(1, "\n", 1);
	return (0);
}

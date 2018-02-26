/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   alpha_mirror.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 20:48:02 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/26 20:48:02 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

char	mirror(char c)
{
	if (c >= 'a' && c <= 'z')
			return ('z' -  (c - 'a'));
	if (c >= 'A' && c <= 'Z')
			return ('Z' -  (c - 'A'));
	return (c);
}

char	is_letter(char c)
{
	if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'))
		return (1);
	return (0);
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
	while (argv[1][i])
		ft_putchar(mirror(argv[1][i++]));
	write(1, "\n", 1);
	return 0;
}
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   paramsum.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 20:01:25 by exam              #+#    #+#             */
/*   Updated: 2018/02/16 20:07:03 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

void putnbr(int nbr)
{
	char x = '0';
	if (nbr >= 10)
	{
		putnbr(nbr / 10);
	}
	x += nbr % 10;
	write(1, &x, 1);
}

int main(int argc, char **argv)
{
	(void)argv;
	putnbr(argc - 1);
	write(1, "\n", 1);
	return (0);
}

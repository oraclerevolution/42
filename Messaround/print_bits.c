/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   print_bits.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 15:34:03 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 15:34:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdio.h>
#include <limits.h>


void	dec_to_binary(int nbr)
{
	if (nbr >= 2)
		dec_to_binary(nbr / 2);
	printf("%d", nbr % 2);
}

void	print_bits(int nbr)
{
	int count;
	char output[8];

	count = 8;

	while (--count >= 0)
	{
		output[count] = '0' + nbr % 2;
		nbr /= 2;
	}
	write(1, output, 8);
}

void	set_bit(int *nbr, int bit, char value)
{
	*nbr |= (value << bit);
}

void	toggle_bit(int *nbr, int bit)
{
	*nbr ^= (1 << bit);
}

int	active_bits(int nbr)
{
	int result;

	result = 0;
	while (nbr != 0)
	{
		result+= nbr % 2;
		nbr/=2;
	}
	return (result);
}

int bit_count(int nbr)
{
	int result;

	result = 0;
	while (nbr != 0)
	{
		result++;
		nbr/=2;
	}
	return (result);
}


int main(int argc, char **argv)
{
	int nbr = 0;
	while (nbr <= INT_MAX)
	{
		dec_to_binary(nbr++);
		printf(" - %d - %d bits active - %d bits total\n", nbr - 1, active_bits(nbr - 1), bit_count(nbr));
	}
	return 0;
}
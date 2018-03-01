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

int reverse_bits(int nbr)
{
	int tmp;

	tmp = 0;
	while (nbr != 0)
	{
		tmp = (tmp << 1) | nbr % 2;
		nbr >>= 1;
	}
	return (tmp);
}

int swap_bits(int nbr)
{
	return (nbr << 4) | (nbr >> 4);
}

int main(int argc, char **argv)
{
	int nbr = 15;
	dec_to_binary(nbr);
	putchar('\n');
	nbr = reverse_bits(nbr);
	dec_to_binary(nbr);
	putchar('\n');
	nbr = swap_bits(nbr);
	dec_to_binary(nbr);
	putchar('\n');
	/*int n;
	int LOL = 50;
	while (nbr <= INT_MAX)
	{
		dec_to_binary(++nbr);
		printf(" - %d - %d bits active - %d bits total\n", nbr, active_bits(nbr), bit_count(nbr));
		n = 0;
		while (n < LOL)
			n++;
	}*/
	return 0;
}
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
	putchar('0' + nbr % 2);
}

void	print_bits(int nbr)
{
	int count;
	char output[8];

	count = 8;

	while (--count >= 0)
	{
		output[count] = '0' + (nbr & 1);
		nbr >>= 1;
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
		tmp = (tmp << 1) | (nbr & 1);
		nbr >>= 1;
	}
	return (tmp);
}

int swap_bits(int nbr)
{
	return (nbr << 4) | (nbr >> 4);
}

int	ft_recursive_power(int nb, int power)
{
	if (power < 0)
		return (0);
	if (power == 0)
		return (1);
	return (nb * ft_recursive_power(nb, power - 1));
}


int bin_to_int(long long bin)
{
	int result;
	int power;

	result = 0;
	power = 0;
	while (bin != 0)
	{
		result += (bin % 10) * ft_recursive_power(2, power);
		bin /= 10;
		++power;
	}
	return (result);
}

long long int_to_bin(int nbr)
{
	int result;
	long long rev;

	result = 0;
	rev = 0;
	while (nbr != 0)
	{
		result = result * 10 + (nbr & 1);
		nbr >>= 1;
	}
	while (result != 0)
	{
		rev = rev * 10 + result % 10;
		result /= 10;
	}
	return (rev);
}

int main(int argc, char **argv)
{
	printf("110110101 is %d\n", bin_to_int(110110101));
	printf("%lu\n", int_to_bin(437));
	printf("%d", 2 | (2 << 1));
	return 0;
	int nbr = 15;
	dec_to_binary(nbr);
	putchar('\n');
	nbr = reverse_bits(nbr);
	dec_to_binary(nbr);
	putchar('\n');
	nbr = swap_bits(nbr);
	dec_to_binary(nbr);
	putchar('\n');


	while (nbr <= INT_MAX)
	{
		dec_to_binary(++nbr);
		printf("\t%d\t%d bits total\n", nbr, bit_count(nbr));
	}
	return 0;
}
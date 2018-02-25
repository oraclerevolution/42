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

int main(int argc, char **argv)
{
	int nbr = 5;
	dec_to_binary(nbr);
	printf("\n");
	print_bits(nbr);
	return 0;
}
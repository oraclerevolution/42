/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   reverse_bits.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/02 10:41:36 by exam              #+#    #+#             */
/*   Updated: 2018/03/02 10:52:46 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

unsigned char reverse_bits(unsigned char octet)
{
	unsigned char result;
	unsigned char tmp[8];
	int index;
	
	result = 0;
	index = 0;
	while (index != 8)
	{
		tmp[index++] = octet % 2;
		octet /= 2;
	}
	index = 0;
	while (index != 8)
		result = (result << 1) | (tmp[index++]);
	return (result);
}

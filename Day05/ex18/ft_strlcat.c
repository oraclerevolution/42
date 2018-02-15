/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlcat.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 01:37:51 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 01:37:51 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

unsigned int	ft_strlcat(char *dest, char *src, unsigned int size)
{
	unsigned int i;
	unsigned int i2;
	unsigned int offset;

	i = 0;
	offset = 0;
	while (dest[offset] != '\0')
		offset++;
	while (offset + i < (size - 1) && src[i] != '\0')
	{
		dest[offset + i] = src[i];
		i++;
	}
	dest[offset + i] = '\0';
	while (src[i] != '\0' && i < size)
		i++;
	i2 = i;
	while (src[i2] != '\0')
		i2++;
	if (i2 >= size && offset > size)
		return (i2 + size);
	return (offset + i2);
}

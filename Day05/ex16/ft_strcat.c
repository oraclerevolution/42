/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcat.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 01:24:16 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 01:24:17 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

char	*ft_strcat(char *dest, char *src)
{
	int i;
	int offset;

	i = 0;
	offset = 0;
	while (dest[offset] != '\0')
		offset++;
	while (src[i] != '\0')
	{
		dest[offset + i] = src[i];
		i++;
	}
	dest[offset + i] = '\0';
	return (dest);
}

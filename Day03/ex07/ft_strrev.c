/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strrev.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 21:02:55 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/07 21:02:56 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

char	*ft_strrev(char *str)
{
	int		i;
	int		length;
	char	tmp;

	i = 0;
	length = 0;
	while (str[length] != '\0')
		length++;
	while (i < (length / 2))
	{
		tmp = str[length - i - 1];
		str[length - i - 1] = str[i];
		str[i] = tmp;
		i++;
	}
	return (str);
}

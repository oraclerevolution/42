/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 06:50:56 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/07 06:50:57 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		ft_strlen(char *str)
{
	char *s;

	s = str;
	while (*s)
		s++;
	return (s - str);
}

int 		ft_strlen2(char *str)
{
	if (*str == '\0')
		return (0);
	return (ft_strlen2(str + 1) + 1);
}

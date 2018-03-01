/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/09 01:04:41 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/09 01:04:41 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_atoi(char *str)
{
	int pos;
	int i;
	int result;

	i = 0;
	result = 0;
	while (str[i] == ' ' || str[i] == '\n' || str[i] == '\f' || \
			str[i] == '\t' || str[i] == '\v' || str[i] == '\r')
		i++;
	if (pos = 1 && (str[i] == '-' || str[i] == '+'))
		if (str[i++] == '-')
			pos = -1;
	while (str[i] >= '0' && str[i] <= '9')
		result = result * 10 + str[i++] - '0';
	return (result * pos);
}

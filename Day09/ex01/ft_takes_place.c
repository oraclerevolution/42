/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_takes_place.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/15 21:37:29 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/15 21:37:29 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

char	get_pm_am(int hour)
{
	if (hour >= 12 && hour < 24)
		return ('P');
	return ('A');
}

void	ft_takes_place(int hour)
{
	int		minutes;
	int		hour2;
	char	letter[2];
	char	*format;

	minutes = hour % 100;
	hour /= 100;
	hour2 = hour + 1;
	letter[0] = get_pm_am(hour);
	letter[1] = get_pm_am(hour2);
	if (hour > 12)
		hour -= 12;
	else if (hour == 0)
		hour = 12;
	if (hour2 > 12)
		hour2 -= 12;
	else if (hour2 == 0)
		hour2 = 12;
	format = "%.2d.%.2d %c.M. AND %.2d.%.2d %c.M.\n";
	printf("THE FOLLOWING TAKES PLACE BETWEEN ");
	printf(format, hour, minutes, letter[0], hour2, minutes, letter[1]);
}

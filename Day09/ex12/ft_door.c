/* ******************************** ****************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_door.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 04:56:26 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 04:56:26 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_door.h"
#include <unistd.h>

void	ft_putstr(char *str)
{
	int i = 0;

	while (str[i])
		i++;
	write(1, str, i);
}

ft_bool	open_door(t_door *door)
{
	ft_putstr("Door opening...\n");
	door->state = OPEN;
	return (TRUE);
}

ft_bool	close_door(t_door *door)
{
	ft_putstr("Door closing...\n");
	door->state = CLOSE;
	return (TRUE);
}

ft_bool	is_door_open(t_door* door)
{
	ft_putstr("Door is open ?\n");
	return (door->state == OPEN);
}

ft_bool	is_door_close(t_door* door)
{
	ft_putstr("Door is close ?\n");
	return (door->state == CLOSE);
}

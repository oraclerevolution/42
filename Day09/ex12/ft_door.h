/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_door.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 04:56:17 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 04:56:18 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_DOOR_H
# define FT_DOOR_H
# define TRUE (1)
# define OPEN (1)
# define CLOSE (0)
# define EXIT_SUCCESS (0)

typedef int		ft_bool;
typedef struct	s_door
{
	ft_bool state;
}				t_door;

#endif

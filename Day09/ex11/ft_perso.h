/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_perso.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 04:50:46 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 04:50:46 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_PERSO_H
# define FT_PERSO_H
# define SAVE_THE_WORLD (0)
# include <string.h>

typedef	struct	s_perso
{
	char	*name;
	float	life;
	int		age;
	int		profession;
}				t_perso;
#endif

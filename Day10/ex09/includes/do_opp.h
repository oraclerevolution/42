/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   do_opp.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/24 23:58:36 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/24 23:58:37 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef DO_OPP_H
# define DO_OPP_H

void			ft_add(int nbr1, int nbr2);
void			ft_sub(int nbr1, int nbr2);
void			ft_mul(int nbr1, int nbr2);
void			ft_div(int nbr1, int nbr2);
void			ft_mod(int nbr1, int nbr2);
void			ft_usage(int nbr1, int nbr2);

typedef struct	s_opp
{
	char	*op;
	void	(*f)(int, int);
}				t_opp;
#endif

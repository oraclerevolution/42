/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   BSQ.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 15:34:03 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 15:34:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "utils.h"

int main()
{
	t_colle colle;
	char charset[7];
	
	colle.colle = 0;
	init_structure(&colle);
	init_string(charset, 7);
	read_from_input(&colle, charset);
	colle.colle = ft_match_colle(charset);
	if(colle.colle <= 0)
		ft_print("aucune");
	else
		ft_print_colle(colle);
	ft_print("\n");
	return (0);
}
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_at.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 17:14:38 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 17:14:38 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

t_list	*ft_list_at(t_list *begin_list, unsigned int nbr)
{
	unsigned int	i;
	t_list			*tmp;

	i = 1;
	tmp = begin_list;
	while (i < nbr && tmp != (void*)0)
	{
		tmp = tmp->next;
		i++;
	}
	if (i != nbr)
		return ((void*)0);
	return (tmp);
}

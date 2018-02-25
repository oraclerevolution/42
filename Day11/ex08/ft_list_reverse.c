/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_reverse.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 01:03:37 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 01:03:37 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

void	ft_list_reverse(t_list **begin_list)
{
	t_list *current;
	t_list *previous;
	t_list *next;

	current = *begin_list;
	if (current == (void*)0 || current->next == (void*)0)
		return ;
	previous = (void*)0;
	while (current->next != (void*)0)
	{
		next = current->next;
		current->next = previous;
		previous = current;
		current = next;
	}
	current->next = previous;
	*begin_list = current;
}

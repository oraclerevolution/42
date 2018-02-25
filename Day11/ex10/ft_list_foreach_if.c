/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_foreach_if.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 01:15:38 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 01:15:38 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

void	ft_list_foreach_if(t_list *begin_list, void (*f)(void *), \
		void *data_ref, int (*cmp)())
{
	t_list *list;

	list = begin_list->next;
	while (list != (void*)0)
	{
		if ((*cmp)(list->data, data_ref))
			(*f)(list->data);
		list = list->next;
	}
}

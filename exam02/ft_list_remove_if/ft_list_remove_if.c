/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remote_if.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: exam <marvin@42.fr>                        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 18:35:38 by exam              #+#    #+#             */
/*   Updated: 2018/02/23 18:41:41 by exam             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)())
{
	t_list *list;
	t_list *previous;

	list = *begin_list;
	previous = NULL;
	while (list != NULL)
	{
		if ((*cmp)(list->data, data_ref) == 0)
		{
			if (previous == NULL)
			{
				previous = list;
				list = list->next;
				free(previous);
			}
			else
			{
				previous->next = list->next;
				free(list);
				list = previous->next;
			}
			continue;
		}
		previous = list;
		list = list->next;
	}
}

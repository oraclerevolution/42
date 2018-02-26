/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_front.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 16:28:44 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 16:28:45 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

t_list	*ft_create_elem(void *data);

void	ft_list_push_front(t_list **begin_list, char *data)
{
	t_list *list;

	if (*begin_list == (void*)0)
		*begin_list = ft_create_elem(data);
	else
	{
		list = ft_create_elem(data);
		list->next = *begin_list;
		*begin_list = list;
	}
}

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

void ft_list_push_front(t_list **begin_list, char *data)
{
	if (*begin_list == NULL)
		*begin_list = ft_create_elem(data);
	else
	{
		t_list *list;

		list = ft_create_elem(data);
		list->next = *begin_list;
		*begin_list = list;
	}
}

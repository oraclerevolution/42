/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_back.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 22:42:04 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 22:42:04 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

void	ft_list_push_back(t_list **begin_list, void *data)
{
	t_list *list;
	t_list *tmp;

	tmp = *begin_list;
	if (tmp == NULL)
	{
		tmp = ft_create_elem(data);
		return ;
	}
	while (tmp->next != (void*)0)
		tmp = tmp->next;
	tmp->next = ft_create_elem(data);
}

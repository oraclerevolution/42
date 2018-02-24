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

t_list	*ft_create_elem(void *data);

void	ft_list_push_back(t_list **begin_list, void *data)
{
	t_list *list;
	t_list *tmp;

	list = ft_create_elem(data);
	tmp = *begin_list;
	while (tmp->next != NULL)
		tmp = tmp->next;
	tmp->next = list;
}

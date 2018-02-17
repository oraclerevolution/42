/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_last.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 11:49:36 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 11:49:36 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

t_list	*ft_list_last(t_list *begin_list)
{
	t_list *tmp;

	if (begin_list->next == NULL)
		return (begin_list);
	tmp = begin_list->next;
	while (tmp->next != NULL)
		tmp = tmp->next;
	return (tmp);
}

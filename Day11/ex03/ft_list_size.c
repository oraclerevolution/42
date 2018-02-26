/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_size.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 16:35:43 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 16:35:43 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_list.h"

int	ft_list_size(t_list *begin_list)
{
	int		i;
	t_list	*list;

	if (begin_list == (void*)0)
		return (0);
	i = 1;
	list = begin_list->next;
	while (list != (void*)0 && i++)
		list = list->next;
	return (i);
}

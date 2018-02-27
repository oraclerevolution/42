/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_clear.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 01:07:17 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 01:07:17 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "ft_list.h"

void	ft_list_clear(t_list **begin_list)
{
	t_list *list;
	t_list *tmp;

	list = *begin_list;
	tmp = NULL;
	while (list != NULL)
	{
		tmp = list;
		list = list->next;
		free(tmp);
	}
	if (begin_list != NULL)
		free(begin_list);
}

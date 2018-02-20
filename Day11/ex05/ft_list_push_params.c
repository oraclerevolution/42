/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_params.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 17:32:44 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 17:32:45 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "ft_list.h"

t_list	*ft_create_elem(void *data)
{
	t_list *tmp;

	if ((tmp = (t_list*)malloc(sizeof(t_list))) == NULL)
		return (NULL);
	tmp->next = (NULL);
	tmp->data = data;
	return (tmp);
}

t_list	*ft_list_push_params(int ac, char **av)
{
	int		i;
	t_list	*list;
	t_list	*tmp;

	if (ac == 1)
		return (NULL);
	i = 2;
	list = ft_create_elem(av[1]);
	while (i < ac)
	{
		tmp = list;
		list = ft_create_elem(av[i]);
		list->next = tmp;
		i++;
	}
	return (list);
}

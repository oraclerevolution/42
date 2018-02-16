/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_create_elem.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 21:58:46 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 21:58:48 by kcausse          ###   ########.fr       */
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

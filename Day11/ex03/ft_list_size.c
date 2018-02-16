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

#include <stdio.h>
#include <stdlib.h>

int ft_list_size(t_list *begin_list)
{
	int i;
	t_list *list;

	i = 0;
	list = begin_list->next;
	while (list->next != NULL)
	{
		list = list->next;
		i++;
	}
	return (i);
}

int main(int argc, char **argv)
{
	t_list *list;
	t_list *ozo;

	list = ft_create_elem("rfgfhfhgfhfgfghgfhgfhg");
	ozo = list;
	ft_list_push_front(&list, "test");
	ft_list_push_front(&list, "1");
	ft_list_push_front(&list, "2");
	ft_list_push_front(&list, "3");
	ft_list_push_front(&list, "4");
	ft_list_push_front(&list, "5");

	while (list->next != NULL)
	{
		printf("%s\n", list->data);
		list = list->next;
	}
	printf("%s\n", list->data);
	printf("%d". ft_list_size(list));
	return 0;
}
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_params.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/17 12:50:16 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/17 12:50:16 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


#include <stdio.h>
#include <stdlib.h>
#include "ft_list.h"

t_list    *ft_create_elem(void *data)
{
    t_list *tmp;
    
    if ((tmp = (t_list*)malloc(sizeof(t_list))) == NULL)
        return (NULL);
    tmp->next = (NULL);
    tmp->data = data;
    return (tmp);
}


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


int ft_list_size(t_list *begin_list)
{
    int i;
    t_list *list;
    
    if (begin_list->next == NULL)
        return (1);
    i = 2;
    list = begin_list->next;
    while (list->next != NULL && i++)
        list = list->next;
    return (i);
}

t_list *ft_list_push_params(int ac, char **av)
{
	t_list *list;

	if (ac == 1)
		return (NULL);
	int i;

	i = 1;
	while (i < ac)
		ft_list_push_front(&list, av[i++]);
	return (list);
}

int main(int argc, char **argv)
{
    t_list *ozo;
    
    ozo = ft_list_push_params(argc, argv);

    while (ozo != NULL && ozo->next != NULL)
    {
        printf("--%s\n", ozo->data);
        ozo = ozo->next;
    }
    return (0);
 }
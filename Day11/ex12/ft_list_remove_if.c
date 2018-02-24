/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 01:58:29 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 01:58:30 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include "ft_list.h"

void ft_list_remove_if(t_list *begin_list, void *data_ref, int (*cmp)())
{
    t_list *list;
    t_list *next;
    t_list *previous;
    
    list = begin_list;
    previous = begin_list;
    while (list != (void*)0)
    {
    	next = list->next;
    	if ((*cmp)(list->next, data_ref))
    	{
    		printf("-del-");
    		previous->next = next;
    		free(list);
    	}
        list = next;
    	previous = list;
    }
}

int	ft_strcmp2(char *s1, char *s2)
{
	if (*s1 == '\0' && *s2 == '\0')
		return (0);
	if (*s1 == *s2)
		return (ft_strcmp2(s1 + 1, s2 + 1));
	return (*s1 - *s2);
}


int cmp(t_list *begin_list, void *data, void *dataref)
{
	if(ft_strcmp2((char*)data, "1") != 0)
		return 0;
    return (1);
}

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
    
    i = 1;
    list = begin_list->next;
    while (list != NULL && i++)
        list = list->next;
    return (i);
}

int main(int argc, char **argv)
{
    t_list *list;
    t_list *ozo;
    
    list = ft_create_elem("rfgfhfhgfhfgfghgfhgfhg");
    ft_list_push_front(&list, "test");
    
    printf("%d\n", ft_list_size(list));
    return 0;
}

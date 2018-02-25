/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   messaround.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 00:51:38 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/07 00:51:39 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdio.h>

void ft_putchar(char c)
{
    write(1, &c, 1);
}

int	ft_strcmp2(char *s1, char *s2)
{
	if (*s1 == '\0' && *s2 == '\0')
		return (0);
	if (*s1 == *s2)
		return (ft_strcmp2(s1 + 1, s2 + 1));
	return (*s1 - *s2);
}

int ft_strcmp3(char *s1, char *s2)
{
	return (*s1 == '\0' && *s2 == '\0' ? 0 : *s1 == *s2 ? ft_strcmp3(s1 + 1, s2 + 1) : *s1 - *s2);
}

int main(int argc, char **argv)
{
    printf("%d\n", t_strcmp("gfhgfhgf", "gfhgfhgf"));
    printf("%d", strcmp("gfhgfhgf", "gfhgfhgf"));
}

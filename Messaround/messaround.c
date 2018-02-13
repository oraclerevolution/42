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

int main(int argc, char **argv)
{
	char test = -127;
    printf("%d", (unsigned char)test);
}

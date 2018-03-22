/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   BSQ.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 15:34:03 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/23 15:34:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef UTILS_H
# define UTILS_H
# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>
# include <fcntl.h>

# define COLLE_ONE (1)
# define COLLE_TWO (2)
# define COLLE_THREE (4)
# define COLLE_FOUR (8)
# define COLLE_FIVE (16)

typedef struct s_colle {
	int colle;
	int width;
	int height;
}				t_colle;

void ft_putchar(char c);
void ft_print(char *str);
void ft_print_colle(t_colle colle);
void ft_putnbr(int nbr);
void read_from_input(t_colle *colle, char *charset);
void init_string(char *str, int length);
void init_structure(t_colle *colle);
char* ft_strcpy(char *dest, char *src, unsigned int length);
int ft_match_colle(char *charset);

#endif
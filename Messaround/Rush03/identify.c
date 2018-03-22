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

#include "utils.h"

void init_string(char *str, int length)
{
	str[--length] = '\0';
	while (--length != 0)
		str[length] = '.';
}

void init_structure(t_colle *colle)
{
	colle->width = 0;
	colle->height = 0;
	colle->colle = 0;
}

void read_from_input(t_colle *colle, char charset[7])
{
	int x;
	char buffer[2];
	
	x = 0;
	buffer[0] = '\0';
	while (read(0, &buffer[1], 1) > 0 && colle->colle != -1)
	{
		if (buffer[1] == '\n')
		{
			if (colle->height == 0 && colle->width != 1)
					charset[1] = buffer[0];
			x = -1;
			colle->height++;
		}
		else
		{
			if (colle->height == 0)
			{
				if (colle->width == 0)
					charset[0] = buffer[1];
				else if (charset[4] == '.')
					charset[4] = buffer[1];
				colle->width++;
			}
			else if (x == 0)
			{
				if (charset[5] == '.')
					charset[5] = buffer[1];
				charset[2] = buffer[1];
			}
		}
		x++;
		if (buffer[1] != '\n')
			buffer[0] = buffer[1];
	}
	charset[3] = buffer[0];
	if (colle->width == 1)
	{
		charset[1] = '.';
		charset[3] = '.';
	}
	if (colle->width <= 2)
		charset[4] = '.';
	if (colle->height == 1)
		charset[3] = '.';
	if (colle->height <= 2)
		charset[5] = '.';
}

int ft_match_colle(char *charset)
{
	char str[5][7];
	int result;
	int i;
	int x;
	
	result = COLLE_ONE | COLLE_TWO | COLLE_THREE | COLLE_FOUR | COLLE_FIVE;
	i = 0;
	
	ft_strcpy(str[0], "oooo-|", 7);
	ft_strcpy(str[1], "/\\\\/**", 7);
	ft_strcpy(str[2], "AACCBB", 7);
	ft_strcpy(str[3], "ACACBB", 7);
	ft_strcpy(str[4], "ACCABB", 7);
	while (i < 7)
	{	
		x = 0;
		while (x < 5)
		{
			if (charset[i] != str[x][i] && charset[i] != '.')
				result &=  ~(1UL << x);
			x++;
		}
		i++;
	}
	return (result);
}
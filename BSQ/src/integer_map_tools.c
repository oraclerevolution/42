/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   integer_map_tools.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:28:09 by wabousfi          #+#    #+#             */
/*   Updated: 2018/02/27 01:56:09 by wabousfi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"

int			**map_to_int(char **map, t_map bsq)
{
	int		**map_int;
	int		line;
	int		column;

	line = 0;
	column = 0;
	if ((map_int = malloc(sizeof(int*) * bsq.nb_line)) == NULL)
		return (NULL);
	while (map[line])
	{
		if ((map_int[line] = malloc(sizeof(int) * bsq.len_line)) == NULL)
			return (NULL);
		while (map[line][column])
		{
			if (map[line][column] == bsq.limits[1])
				map_int[line][column] = 0;
			else
				map_int[line][column] = 1;
			column++;
		}
		column = 0;
		line++;
	}
	return (map_int);
}

char		convert_char(int nb, t_position pos, t_map bsq)
{
	if (nb == pos.value)
		return (bsq.limits[2]);
	else if (nb == 0)
		return (bsq.limits[1]);
	return (bsq.limits[0]);
}

void		opti_tab_gen(int **tab, t_position pos, t_map bsq)
{
	char	*buffer;
	int		i;
	int		x;
	int		y;

	i = 0;
	x = 0;
	y = 0;
	if ((buffer = malloc(sizeof(char) * bsq.read_size + 1)) == NULL)
		return ;
	while (y < bsq.nb_line)
	{
		while (x < bsq.len_line)
		{
			buffer[i] = convert_char(tab[y][x], pos, bsq);
			i++;
			x++;
		}
		x = 0;
		buffer[i] = '\n';
		i++;
		y++;
	}
	buffer[i] = '\0';
	ft_print(buffer);
}

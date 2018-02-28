/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   algorigthms.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:27:55 by wabousfi          #+#    #+#             */
/*   Updated: 2018/02/27 02:02:23 by wabousfi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"

int		check_move(int **map, int y, int x)
{
	if ((map[y - 1][x] != 0) && (map[y][x - 1] != 0)
			&& (map[y - 1][x - 1] != 0) && map[y][x] != 0)
		return (1);
	return (0);
}

int		recup_bigger(int **map, int y, int x)
{
	int		min;

	min = map[y - 1][x];
	if (min > map[y][x - 1])
		min = map[y][x - 1];
	if (min > map[y - 1][x - 1])
		min = map[y - 1][x - 1];
	return (min);
}

void	find_square(int **map, t_map bsq)
{
	int		y;
	int		x;

	y = 1;
	x = 1;
	while (y < bsq.nb_line)
	{
		while (x < bsq.len_line)
		{
			if (check_move(map, y, x) == 1)
				map[y][x] = recup_bigger(map, y, x) + 1;
			x++;
		}
		x = 1;
		y++;
	}
	isole_square(map, bsq);
}

void	isole_square(int **map, t_map bsq)
{
	t_position	pos;
	int			line;
	int			column;

	line = 0;
	column = 0;
	init_position(&pos, map[line][column], line, column);
	while (line < bsq.nb_line)
	{
		while (column < bsq.len_line)
		{
			if (pos.value <= map[line][column])
				if (pos.value != map[line][column])
					init_position(&pos, map[line][column], line, column);
			column++;
		}
		column = 0;
		line++;
	}
	remake_map(map, pos, bsq);
}

void	remake_map(int **map, t_position pos, t_map bsq)
{
	int		line;
	int		column;
	int		value;

	value = pos.value;
	init_position(&pos, (pos.value + 1), pos.y, pos.x);
	line = pos.y;
	column = pos.x;
	while (line > (pos.y - value))
	{
		while (column > (pos.x - value))
			map[line][column--] = pos.value;
		column = pos.x;
		line--;
	}
	if (bsq.nb_line > 1000)
		opti_tab_gen(map, pos, bsq);
	else
		put_end(map, pos, bsq);
}

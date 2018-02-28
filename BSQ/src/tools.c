/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tools.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:28:19 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/27 01:56:25 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"
#include <unistd.h>

void		put_end(int **map, t_position pos, t_map bsq)
{
	int		x;
	int		y;

	x = 0;
	y = 0;
	while (y < bsq.nb_line)
	{
		while (x < bsq.len_line)
		{
			if (map[y][x] == pos.value)
				ft_putchar(bsq.limits[2]);
			else if (map[y][x] == 0)
				ft_putchar(bsq.limits[1]);
			else
				ft_putchar(bsq.limits[0]);
			x++;
		}
		ft_putchar('\n');
		x = 0;
		y++;
	}
}

int			init_mapsize_vars(char *buf, int *i, int *line_count, char **tmp)
{
	*buf = 0;
	*i = 0;
	*line_count = 1;
	if ((*tmp = malloc(sizeof(char) * 14)) == NULL)
		return (0);
	return (1);
}

void		init_position(t_position *pos, int value, int y, int x)
{
	pos->value = value;
	pos->x = x;
	pos->y = y;
}

int			init_getmap_vars(char *pathname, int *i, int *column, int *line)
{
	int		fd;

	*column = 0;
	*i = -1;
	*line = 0;
	fd = open(pathname, O_RDONLY);
	if (fd == -1)
		ft_print("map error\n");
	return (fd);
}

void		init_struct(t_map *bsq)
{
	bsq->read_size = bsq->nb_line * bsq->len_line + bsq->nb_line;
}

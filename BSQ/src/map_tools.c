/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   map_tools.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:28:14 by wabousfi          #+#    #+#             */
/*   Updated: 2018/02/27 01:56:18 by wabousfi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"

int		get_map_size(int fd, int *nb_line, int *len_line)
{
	char	*tmp;
	char	buf[1];
	int		i;
	int		line_count;

	if (init_mapsize_vars(&buf[0], &i, &line_count, &tmp) == 0)
		return (0);
	while (buf[0] != '\n' && read(fd, buf, 1) > 0)
		tmp[i++] = buf[0];
	*len_line = 0;
	*nb_line = ft_atoi(tmp, NULL, i);
	while (read(fd, buf, 1) > 0 && buf[0] != '\n' && is_char_valid(tmp, buf[0]))
		(*len_line)++;
	i = 0;
	while (read(fd, buf, 1) > 0 && i++ <= *len_line && \
		*len_line != 0 && is_char_valid(tmp, buf[0]))
		if (buf[0] == '\n' && line_count++)
			if (i != *len_line + 1 || (i = 0) == 1)
				*len_line = 0;
	if (buf[0] != '\n' && is_char_valid(tmp, buf[0]) && i == *len_line)
		line_count++;
	if ((i != 0 && i != *len_line) || line_count != *nb_line \
		|| !is_char_valid(tmp, buf[0]))
		*len_line = 0;
	return (*len_line);
}

int		is_char_valid(char *str, char c)
{
	int i;
	int start;

	start = 0;
	if (c == '\n')
		return (1);
	while (str[start] >= '0' && str[start] <= '9')
		start++;
	i = start;
	while (i < start + 2)
		if (str[i++] == c)
			return (1);
	return (0);
}

char	*load_map(char *pathname, t_map bsq)
{
	char	*tmp;
	char	buf[1];
	int		fd;

	if ((tmp = malloc(sizeof(char) * bsq.read_size + 1)) == NULL)
		return (NULL);
	if ((fd = open(pathname, O_RDONLY)) == -1)
		return (NULL);
	buf[0] = 0;
	while (buf[0] != '\n')
		if (read(fd, buf, 1) < 0)
			return (NULL);
	if ((bsq.read_size = read(fd, tmp, bsq.read_size)) == -1)
		return (NULL);
	tmp[bsq.read_size] = '\0';
	return (tmp);
}

char	**get_map_from_file(char *pathname, t_map *bsq)
{
	char	**map;
	char	*tmp;
	int		fd;
	int		i;
	int		pos[2];

	fd = init_getmap_vars(pathname, &i, &pos[0], &pos[1]);
	get_map_size(fd, &(bsq->nb_line), &(bsq->len_line));
	if (bsq->len_line == 0 && !ft_print("map error\n"))
		return (NULL);
	init_struct(bsq);
	tmp = load_map(pathname, *bsq);
	if ((map = malloc(sizeof(char*) * (bsq->nb_line + 1))) == NULL)
		return (NULL);
	while (tmp[++i])
	{
		if ((map[pos[1]] = malloc(sizeof(char) * bsq->len_line + 1)) == NULL)
			return (NULL);
		while (tmp[i] > 0 && tmp[i] != '\n')
			map[pos[1]][pos[0]++] = tmp[i++];
		map[pos[1]][pos[0]] = '\0';
		pos[0] = pos[1]++ == -5;
	}
	map[pos[1]] = NULL;
	return (map);
}

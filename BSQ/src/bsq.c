/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bsq.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:28:04 by wabousfi          #+#    #+#             */
/*   Updated: 2018/02/28 04:56:03 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "bsq_functions.h"

char g_limits[3];

int		main(int argc, char **argv)
{
	int			i;
	int			**tab;
	char		**map;
	t_map		bsq;

	i = 0;
	if (argc == 1)
		return (0);
	while (++i < argc)
	{
		if (is_file_valid(argv[i], bsq.limits))
			if ((map = get_map_from_file(argv[i], &bsq)) != NULL)
			{
				tab = map_to_int(map, bsq);
				find_square(tab, bsq);
			}
		if (i != argc - 1)
			write(1, "\n", 1);
	}
	return (0);
}

int		is_file_valid(char *path, char *limits)
{
	int		fd;
	int		count;
	int		index;
	int		size;
	char	buffer[14];

	if ((fd = open(path, O_RDONLY)) == -1)
		return (ft_print("map error\n"));
	size = read(fd, buffer, 14);
	index = 0;
	if (size < 6 || (count = ft_atoi(buffer, &index, size)) <= 0)
		return (ft_print("map error\n"));
	count = 0;
	while (index < size && buffer[index] != '\n' && count != 4)
	{
		limits[count] = buffer[index];
		count++;
		index++;
	}
	if (count != 3)
		return (ft_print("map error\n"));
	return (1);
}

char	*get_map_from_input(void)
{
	char	*input;
	char	*output;
	char	buffer[1024];
	int		bufsize;

	output = NULL;
	while ((bufsize = read(0, buffer, 1024)) > 0)
	{
		if ((input = ft_strdup2(buffer, bufsize)) == NULL)
			return (NULL);
		if (output != NULL)
			output = ft_concat_strings(&output, input, bufsize);
		else
			output = input;
	}
	return (output);
}

/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_display_file.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 07:27:31 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 07:27:32 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <fcntl.h>

void	print(char *str, int max)
{
	int i;

	i = 0;
	while (str[i] && i != max)
		i++;
	write(1, str, i);
}

int		main(int argc, char **argv)
{
	int		file;
	int		size;
	char	buffer[4096];

	if (argc != 2)
	{
		print(argc == 1 ? "File name missing.\n" : "Too many arguments.\n", -1);
		return (0);
	}
	file = open(argv[1], O_RDONLY);
	while ((size = read(file, buffer, 4096)))
		print(buffer, size);
	close(file);
	return (0);
}

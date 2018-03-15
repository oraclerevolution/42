/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_cat.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 07:16:11 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 07:16:12 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <fcntl.h>

void	print(char *str, int size)
{
	int i;

	i = 0;
	while (str[i] && i != size)
		i++;
	write(1, str, i);
}

int		main(int argc, char **argv)
{
	int		i;
	int		file;
	int		size;
	char	buffer[4096];

	if (argc == 1)
		while (1)
			(void)argc;
	i = 1;
	while (i < argc)
	{
		file = open(argv[1], O_RDONLY);
		if (file == -1)
		{
			print("cat: ", -1);
			print(argv[i++], -1);
			print(": No such file or directory\n", -1);
			continue;
		}
		while ((size = read(file, buffer, 4096)))
			print(buffer, size);
		close(file);
		i++;
	}
	return (0);
}

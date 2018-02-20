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

void print(char *str)
{
	int i;

	i = 0;
	while (str[i])
		i++;
	write(1, str, i);
}

int main(int argc, char **argv)
{
	int seeker;
	if (argc != 2)
	{
		print(argc == 1 ? "File name missing.\n" : "Too many arguments.\n");
		return (0);
	}
	
	seeker = open(argv[1], O_RDONLY);

	return 0;
}
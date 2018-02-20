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
	int i;
	if (argc == 1)
		while(1)
			(void)argc;
	
	i = 1;
	while (i < argc)
	{
		print("cat: ");
		print(argv[i]);
		print(": No such file or directory\n");
		i++;
	}
	return 0;
}
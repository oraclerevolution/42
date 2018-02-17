/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_params.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 09:20:26 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 09:20:27 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putchar(char c);

int		main(int argc, char **argv)
{
	int i;
	int arg;

	arg = 1;
	while (arg < argc)
	{
		i = 0;
		while (argv[arg][i])
			ft_putchar(argv[arg][i++]);
		ft_putchar('\n');
		arg++;
	}
	return (0);
}

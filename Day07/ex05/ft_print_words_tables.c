/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_words_tables.c                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/13 00:29:14 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/13 00:29:15 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void		ft_putchar(char c);

void		ft_print_words_tables(char **tab)
{
	int i;
	int c;

	c = 0;
	while (tab[c][0] != 0)
	{
		i = 0;
		while (tab[c][i] != '\0')
		{
			ft_putchar(tab[c][i++]);
			i++;
		}
		ft_putchar('\n');
		c++;
	}
}

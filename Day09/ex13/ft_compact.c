/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_compact.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 10:37:22 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 10:37:23 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_compact(char **tab, int length)
{
	int lastpos;
	int i;

	i = 0;
	while (i < length && tab[i] != ((void*)0))
		i++;
	lastpos = i;
	while (++i < length)
		if (tab[i] != ((void*)0))
			tab[lastpos++] = tab[i];
	return (lastpos);
}

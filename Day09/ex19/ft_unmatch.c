/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_unmatch.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/16 11:55:02 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/16 11:55:02 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int ft_unmatch(int *tab, int length)
{
	int i;
	int i2;

	i = 0;
	while (i < length)
	{
		i2 = 0;
		while (i2 < length && tab[i] != tab[i2])
			i2++;
		if (i2 == length)
			return (tab[i]);
		i++;
	}
}

int main(void)
{
	int *tab = {};
}
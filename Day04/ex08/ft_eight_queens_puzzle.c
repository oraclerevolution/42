/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_eight_queens_puzzle.c                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/12 05:03:26 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/12 05:03:27 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_eight_queen_puzzle(int a)
{
	if (a != 92)
		return (ft_eight_queen_puzzle(a + 1));
	return (a);
}

int	ft_eight_queens_puzzle(void)
{
	return (ft_eight_queen_puzzle(1));
}

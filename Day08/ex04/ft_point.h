/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_point.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/14 02:43:22 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/14 02:43:22 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

typedef struct t_point
{
	int x;
	int y;
};

void set_point(t_point *point)
{
	point->x = 42;
	point->y = 21;
}

int main(void)
{
	t_point point;
	set_point(&point);
	return (0);
}
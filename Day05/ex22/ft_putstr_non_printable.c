/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_putstr_non_printable.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 03:26:18 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 03:26:18 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putchar(char c);

void	print_hex(int value)
{
	char	ch[2];
	int		i;

	i = 1;
	while (value != 0)
	{
		ch[i--] = value % 16 < 10 \
				? value % 16 + '0' : value % 16 + ('a' - 10);
		value /= 16;
	}
	while (i >= 0)
		ch[i--] = '0';
	ft_putchar('\\');
	ft_putchar(ch[0]);
	ft_putchar(ch[1]);
}

int		ft_putstr_non_printable(char *str)
{
	int i;

	i = 0;
	while (str[i] != '\0')
	{
		if (str[i] < ' ' || str[i] > '~')
			print_hex(str[i]);
		else
			ft_putchar(str[i]);
		i++;
	}
	return (0);
}

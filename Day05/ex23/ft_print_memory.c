/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_print_memory.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 22:33:56 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 22:34:00 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	ft_putchar(char c);

void	print_hex(int value, int length)
{
	char	output[sizeof(int) * 2];
	int		i;

	i = sizeof(int) * 2 - 1;
	while (value != 0)
	{
		output[i--] = value % 16 < 10 \
				? value % 16 + '0' : value % 16 + ('a' - 10);
		value /= 16;
	}
	while (i >= 0)
		output[i--] = '0';
	i = (length <= 0) ? 0 : (sizeof(int) * 2) - length;
	while (i < ((int)sizeof(int) * 2))
	{
		if (output[i] >= 32 && output[i] <= 126)
			ft_putchar(output[i]);
		else
			ft_putchar('0');
		i++;
	}
}

void	print_mem_line(void *start, unsigned char *addr, int length)
{
	int c;

	print_hex((int)addr - (int)start, -1);
	ft_putchar(':');
	ft_putchar(' ');
	c = 0;
	while (c < 16)
	{
		if (c < length && c < 16)
			print_hex(addr[c], 2);
		else
		{
			ft_putchar(' ');
			ft_putchar(' ');
		}
		if (c & 1)
			ft_putchar(' ');
		c++;
	}
}

void	*ft_print_memory(void *addr, unsigned int size)
{
	unsigned char	*curr;
	unsigned char	*end;
	unsigned int	c;

	curr = (unsigned char*)addr;
	end = curr + size;
	while (curr < end && end - curr != 1)
	{
		print_mem_line(addr, curr, size);
		c = 0;
		while (c < size && c < 16)
		{
			if (curr[c] >= 32 && curr[c] <= 128)
				ft_putchar(curr[c]);
			else
				ft_putchar('.');
			c++;
		}
		curr += 16;
		size -= 16;
		ft_putchar('\n');
	}
	return (0);
}

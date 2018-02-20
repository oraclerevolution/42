/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/20 15:19:53 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/20 15:19:54 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdarg.h>

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

void	ft_putnbr(int nb)
{
	int overflow;

	overflow = 0;
	if (nb < 0)
	{
		ft_putchar('-');
		if (nb == -2147483648)
		{
			nb = 2147483647;
			overflow = 1;
		}
		else
			nb = -nb;
	}
	if (nb >= 10)
		ft_putnbr(nb / 10);
	ft_putchar((nb % 10) + '0' + overflow);
}


void	ft_putstr(char *str)
{
	int i;

	i = 0;
	while (str[i])
		i++;
	write(1, str, i);
}

int	ft_printf(char *format, int argc, ...)
{
	int charcount;
	int i;
	va_list args;

	i = 0;
	charcount = 0;
	va_start(args, argc);

	while (format[i] != '\0')
	{
		if (format[i] == '%')
		{
			switch(format[i + 1])
			{
				case 's':
					ft_putstr(va_arg(args, char*));
					i++;
				break;
				case 'd':
					ft_putnbr(va_arg(args, int));
					i++;
				break;
				case 'c': case ' ': case '%':
					write(1, format + i + 1, 1);
					i++;
				break;
				default:
					ft_printf("\n<<<!!! ft_printf Error! Unknown argument %%c !!!>>>\n", 1, format[i + 1]);
					return (-1);
				break;

			}
			i++;
			continue;
		}
		write(1, format + i, 1);
		i++;
	}

	va_end(args);
	return (charcount);
}

int main(int argc, char **argv)
{
	ft_printf("Salut! %s %d", 1, "test", 475);
	return 0;
}
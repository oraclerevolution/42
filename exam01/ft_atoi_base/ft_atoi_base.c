/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 04:43:06 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 04:43:06 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		get_val_frm_base(char c, char *base)
{
	int i;

	i = 0;
	while (base[i] != '\0')
	{
		if (c == base[i])
			return (i);
		i++;
	}
	return (-1);
}

int		is_base_correct(char *base)
{
	int i;
	int i2;

	i = 0;
	i2 = 0;
	while (base[i] != '\0')
	{
		if (base[i] == '+' || base[i] == '-')
			return (0);
		i2 = i + 1;
		while (base[i2] != '\0')
		{
			if (base[i] == base[i2])
				return (0);
			i2++;
		}
		i++;
	}
	return (1);
}

int		skip_sign(char c, int *positive)
{
	if (c == '-' || c == '+')
	{
		*positive = (c == '-') ? -1 : 1;
		return (1);
	}
	*positive = 1;
	return (0);
}

int		ft_atoi_base(char *str, char *base)
{
	int pos;
	int i;
	int length;
	int result;

	i = 0;
	result = 0;
	length = 0;
	while (base[length] != '\0')
		length++;
	if (length <= 1 || !is_base_correct(base))
		return (0);
	while (str[i] == ' ' || str[i] == '\n' || str[i] == '\f' || \
			str[i] == '\t' || str[i] == '\v' || str[i] == '\r')
		i++;
	i += skip_sign(str[i], &pos);
	while (get_val_frm_base(str[i], base) != -1)
		result = (result * length) + get_val_frm_base(str[i++], base);
	if (str[i] != '\0' && str[i] != '-' && str[i] != '+' && \
	get_val_frm_base(str[i], base) == -1)
		return (0);
	return (result * pos);
}

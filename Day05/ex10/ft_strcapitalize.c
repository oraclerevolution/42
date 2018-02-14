/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcapitalize.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/09 05:42:20 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/09 05:42:20 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

char	is_letter(char c)
{
	if (c >= 'a' && c <= 'z')
		return (1);
	if (c >= 'A' && c <= 'Z')
		return (2);
	return (0);
}

char	is_separator(char c)
{
	return (c == ' ' || c == '/' || c == ',' || c == '-' || c == '+');
}

char	*ft_strcapitalize(char *str)
{
	int i;
	int chartype;

	i = 0;
	while (str[i] != '\0')
	{
		chartype = is_letter(str[i]);
		if (chartype == 1)
		{
			if (i == 0)
				str[i] -= 32;
			else if (is_separator(str[i - 1]))
				str[i] -= 32;
		}
		else if (chartype == 2 && i != 0 && !is_separator(str[i - 1]))
			str[i] += 32;
		i++;
	}
	return (str);
}

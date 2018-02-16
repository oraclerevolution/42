/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_rot42.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/15 23:41:15 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/15 23:41:16 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		is_letter(char c)
{
	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
		return (1);
	return (0);
}

int		letter_loops_back(char c)
{
	if (c >= 'a' && c <= 'z')
		return (c > 'i');
	return (c > 'I');
}

int		get_new_letter(char c)
{
	if (c > 'i')
		return ('a' + 16 + (c - 'z'));
	return ('A' + 16 + (c - 'Z'));
}

char	*ft_rot42(char *str)
{
	int i;

	i = 0;
	while (str[i] != '\0')
	{
		if (is_letter(str[i]))
		{
			if (letter_loops_back(str[i]))
				str[i] = get_new_letter(str[i]);
			else
				str[i] += 16;
		}
		i++;
	}
	return (str);
}

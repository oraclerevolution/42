/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strncmp.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/10 11:49:13 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/10 11:49:13 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_strncmp(char *s1, char *s2, unsigned int n)
{
	unsigned int i;

	i = 0;
	while (i < n && (unsigned char)s1[i] == (unsigned char)s2[i] && \
		s1[i] != '\0' && s2[i] != '\0')
		i++;
	return (s1[i] - s2[i]);
}

int	true_ft_strncmp(char *s1, char *s2, unsigned int n)
{
	unsigned int i;

	i = 0;
	while (i < n && (unsigned char)s1[i] == (unsigned char)s2[i] && \
		s1[i] != '\0' && s2[i] != '\0')
		i++;
	return (i == n ? (0) : (s1[i] - s2[i]));
}

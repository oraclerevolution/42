/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_boolean.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kcausse <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/13 04:29:01 by kcausse           #+#    #+#             */
/*   Updated: 2018/02/13 04:29:02 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_BOOLEAN

#define FT_BOOLEAN
#include <unistd.h>
#define EVEN(nbr) (nbr & 1)
#define TRUE (1)
#define FALSE (0)
#define EVEN_MSG "I have an even number of arguments."
#define ODD_MSG "I have an odd number of arguments."
#define SUCCESS (0)
typedef int t_bool;

#endif

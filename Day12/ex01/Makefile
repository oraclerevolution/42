#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kcausse <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/14 17:26:57 by kcausse           #+#    #+#              #
#    Updated: 2018/02/14 17:27:27 by kcausse          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME = ex01

all: $(NAME)

$(NAME):
	gcc -Wall -Wextra -Werror ft_cat.c -o ft_cat

clean:
	/bin/rm -f *.o

fclean:	clean
	/bin/rm -f ft_cat

re: fclean
	make
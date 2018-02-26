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

NAME = ex00

all: $(NAME)

$(NAME):
	gcc -Wall -Wextra -Werror ft_display_file.c -o ft_display_file

clean:
	/bin/rm -f *.o

fclean:	clean
	/bin/rm -f ft_display_file

re: fclean
	make
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/25 23:40:56 by wabousfi          #+#    #+#              #
#    Updated: 2018/02/26 20:43:09 by wabousfi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME	= ./bsq

RM	= rm -f

all:
	gcc -Wall -Wextra -Werror -o bsq -I ./include src/*.c


test:
	gcc -o bsq -I ./include src/*.c

clean	:
	$(RM) *.o

fclean	: clean
	$(RM) $(NAME)
re	: fclean all

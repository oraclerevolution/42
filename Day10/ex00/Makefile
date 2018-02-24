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
	gcc -Wall -Wextra -Werror -Iincludes -c  srcs/ft_putchar.c srcs/ft_putstr.c srcs/ft_swap.c srcs/ft_strcmp.c srcs/ft_strlen.c
	ar rc libft.a ft_putchar.o ft_putstr.o ft_swap.o ft_strcmp.o ft_strlen.o

clean:
	/bin/rm -f ft_putchar.o ft_putstr.o ft_swap.o ft_strcmp.o ft_strlen.o

fclean:	clean
	/bin/rm -f libft.a ft_putchar.o ft_putstr.o ft_swap.o ft_strcmp.o ft_strlen.o

re: fclean
	make
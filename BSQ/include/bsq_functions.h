/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bsq.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: wabousfi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/26 01:27:46 by wabousfi          #+#    #+#             */
/*   Updated: 2018/02/28 04:58:08 by kcausse          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef BSQ_FUNCTIONS_H
# define BSQ_FUNCTIONS_H

# include <fcntl.h>
# include <unistd.h>
# include <stdlib.h>

typedef struct		s_position
{
	int			x;
	int			y;
	int			value;
}					t_position;

typedef struct		s_map
{
	int			nb_line;
	int			len_line;
	int			read_size;
	char		limits[3];
}					t_map;

char				*ft_concat_strings(char **dest, char *src, int size);
char				**get_map_from_file(char *pathname, t_map *bsq);
char				convert_char(int nb, t_position pos, t_map bsq);
char				*load_map(char *pathname, t_map bsq);
char				*get_map_from_input(void);
char				*ft_strdup2(char *src, int maxlength);
int					init_mapsize_vars(char *buf, int *i, \
						int *line_count, char **tmp);
int					init_getmap_vars(char *pathname, \
						int *i, int *column, int *line);
int					get_map_size(int fd, int *nb_line, int *len_line);
int					ft_atoi(char *str, int *index, int maxsize);
int					is_file_valid(char *path, char *limits);
int					recup_bigger(int **map, int x, int y);
int					**map_to_int(char **map, t_map bsq);
int					check_move(int **map, int y, int x);
int					is_char_valid(char *str, char c);
int					ft_print(char *str);
int					size(char *str);
void				init_position(t_position *pos, int value, int y, int x);
void				opti_tab_gen(int **tab, t_position pos, t_map bsq);
void				remake_map(int **map, t_position pos, t_map bsq);
void				put_end(int **map, t_position pos, t_map bsq);
void				isole_square(int **map, t_map bsq);
void				put_int_tab(int **map, t_map bsq);
void				find_square(int **map, t_map bsq);
void				init_struct(t_map *bsq);
void				ft_putchar(char c);

#endif

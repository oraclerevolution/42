/* ************************************************************************** */
/*                                                                            */
/*   read_input.c                                                             */
/*                                                                            */
/*                                                                            */
/*   Store the standard entry (stdin) inside an two dimensionnal array,       */
/*   the separator being newlines.                                            */
/*                                                                            */
/*   Does not handle variable-length lines                                    */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <stdlib.h>
#define BUFFER_SIZE (1)

typedef struct s_input {
	char **input;
	int width;
	int height;
}				t_input;

void init_string_array(char ***output, int w, int h, char ***cpy, int size)
{
	char **tmp;
	int i;
	int x;
	
	x = 0;
	tmp = (char**)malloc(sizeof(char*) * h);
	if (tmp == NULL)
	{
		*output = NULL;
		return ;
	}
	while (x < h)
	{
		tmp[x] = (char*)malloc(sizeof(char) * w);
		if (tmp[x] == NULL)
		{
			*output = NULL;
			return ;
		}
		if (cpy != NULL && x < size) 
		{
			i = 0;
			while (i < w && i <= size && (*cpy)[x][i] != '\n')
			{
				if ((*cpy)[x][i] >= 32 && (*cpy)[x][i] < 128)
					tmp[x][i] = (*cpy)[x][i];
				else
					tmp[x][i] = ' ';
				i++;
			}
		}
		x++;
	}
	if (cpy != NULL)
	{
		x = 0;
		while (x < size)
		{
			free((*cpy)[x]);
			x++;
		}
		free(*cpy);
	}
	*output = tmp;
}

void init_variables(int *size, char ***tmp, t_input *output, int *x)
{
	*size = BUFFER_SIZE;
	init_string_array(tmp, BUFFER_SIZE, BUFFER_SIZE, NULL, 0);
	output->width = 0;
	output->height = 0;
	*x = 0;
}

t_input read_from_input()
{
	t_input output;
	char buffer[1];
	char **tmp;
	int x;
	int size;
	
	init_variables(&size, &tmp, &output, &x);
	while (read(0, buffer, 1) > 0)
	{
		if (buffer[0] == '\n')
		{
			if (output.height == 0)
				output.width = x;
			x = 0;
			output.height++;
			if (output.height >= size)
			{
				init_string_array(&tmp, output.width, size * 2, &tmp, size);
				size *= 2;
			}
		}
		else
		{
			if (output.width == 0 || (output.width != 0 && x < output.width ))
				tmp[output.height][x] = buffer[0];
			x++;
			if (x > size)
			{
				init_string_array(&tmp, (output.width == 0 ? size * 2: output.width), size * 2, &tmp, size);
				size *= 2;
			}
		}
	}
	init_string_array(&output.input, output.width, output.height, &tmp, size);
	return output;
}

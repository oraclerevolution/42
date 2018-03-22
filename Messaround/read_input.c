/* ************************************************************************** */
/*                                                                            */
/*   read_input.c                                                             */
/*                                                                            */
/*                                                                            */
/*   Store the standard entry (stdin) inside an two dimensionnal array,       */
/*   the separator being newlines.                                            */
/*                                                                            */
/*   Every line is null terminated properly.                                  */
/*                                                                            */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <stdlib.h>
#define BUFFER_SIZE (1)

typedef struct s_input {
	char **input;
	int max_width;
	int height;
}				t_input;

char safechar(char c)
{
	if (c >= 32 && c <= 126)
		return (c);
	return (' ');
}

int init_string_array(char ***output, int w, int h, char ***cpy, int size, int current_height)
{
	char **tmp;
	int i;
	int x;
	
	x = 0;
	tmp = (char**)malloc(sizeof(char*) * h);
	if (tmp == NULL)
		return (0);
	while (x < h)
	{
		tmp[x] = (char*)malloc(sizeof(char) * (w + 1));
		if (tmp[x] == NULL)
			return (0);
		if (cpy != NULL && x < size && x <= current_height) 
		{
			i = 0;
			while (i < w && i <= size  && (*cpy)[x][i] != '\0')
			{
				tmp[x][i] = safechar((*cpy)[x][i]);
				i++;
			}
			if (i < w)
				tmp[x][i] = '\0';
		}
		tmp[x][w] = '\0';
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
	return (1);
}

int init_variables(int *size, char ***tmp, t_input *output, int *x)
{
	*size = BUFFER_SIZE;
	output->input = NULL;
	output->max_width = 0;
	output->height = 0;
	*x = 0;
	return (init_string_array(tmp, BUFFER_SIZE, BUFFER_SIZE, NULL, 0, BUFFER_SIZE));
}

void fill_empty(char **tmp, int x, int max_height)
{
	while (--max_height != 0)
		tmp[max_height][x] = '\0';
}

t_input read_from_input()
{
	t_input output;
	char buffer[1];
	char **tmp;
	int x;
	int size;
	
	if (!init_variables(&size, &tmp, &output, &x))
		return (output = (t_input){.max_width= -1, .height= -1});
	while (read(0, buffer, 1) > 0 && output.height != -1)
	{
		if (buffer[0] == '\n')
		{
			if (output.height == 0)
				output.max_width = x;
			else if (x != output.max_width)
				tmp[output.height][x] = '\0';
			x = 0;
			output.height++;
			if (output.height >= size)
			{
				if (!init_string_array(&tmp, output.max_width, size * 2, &tmp, size, output.height))
					return (output = (t_input){.max_width= -1, .height= -1});
				size *= 2;
			}
		}
		else
		{
			if (output.max_width == 0 || (output.max_width != 0 && x < output.max_width))
				tmp[output.height][x] = safechar(buffer[0]);
			else if ((output.max_width != 0 && x >= output.max_width))
			{
				if (!init_string_array(&tmp, size * 2, size * 2, &tmp, size, output.height))
					return (output = (t_input){.max_width= -1, .height= -1});
				output.max_width++;
				tmp[output.height][x] = safechar(buffer[0]);
				fill_empty(tmp, x, output.height);
				size *= 2;
			}
			x++;
			if (x > size)
			{
				if (!init_string_array(&tmp, (output.max_width == 0 ? size * 2: output.max_width), size * 2, &tmp, size, output.height))
					return (output = (t_input){.max_width= -1, .height= -1});
				size *= 2;
			}
		}
	}
	if (!init_string_array(&output.input, output.max_width, output.height, &tmp, size, size))
		output = (t_input){.max_width= -1, .height= -1};
	return (output);
}

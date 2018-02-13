/* Type: program 													 		*/
/* Function allowed: write 													*/
/* Must print the alphabet in reverse, with every two letters being in caps */
/* Must also print a new line after that 								    */
/* E.g: zYxWvUtSrQpOnMlKjIhGfEdCbA 											*/

#include <unistd.h>

int main()
{
	char c;
	char l;
	
	c = 'z';
	l = 'Y';
	while (c >= 'a')
	{
		write(1, &c, 1);
		write(1, &l, 1);
		c-=2;
		l-=2;
	}
	write(1, "\n", 1);
	return (0);
}

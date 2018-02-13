/* Type: program 													 		*/
/* Function allowed: write 													*/
/* Must print every numbers from 0 to 9 in reverse, followed by a new line  */

#include <unistd.h>

int main()
{
	char n;
	
	n = '0';
	while (n++ < '9')
		write(1, &n, 1);
	write(1, "\n", 1);
	return (0);
}

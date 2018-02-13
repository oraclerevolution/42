/* Type: program 													 		*/
/* Function allowed: write 													*/
/* Must print the letter 'z', followed by a new line				    	*/

#include <unistd.h>

int main()
{
	write(1, "z\n", 2);
	return (0);
}

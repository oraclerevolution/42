/* Type: program 													 		*/
/* Function allowed: write 													*/
/* Must print "hello World!", followed by a new line 				    	*/

#include <unistd.h>

int main()
{
	write(1, "Hello World!\n", 13);
	return (0);
}

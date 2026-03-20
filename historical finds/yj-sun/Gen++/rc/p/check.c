/*ident	"@(#)gen++:d.pkg/rc/p/check.c	1.3" */
#include <ctype.h>
#include <stdio.h>
#include <string.h>

char* find_(char* str)
{
    char* s = str;
    while(*s != '\0') {
        if(*s++ == '_') {
            return s;
        }
    }    
    return str;
}

int oneOf(char c, char* str)
{
	char* s = str;
	while(*s != '\0') {
		if(*s++ == c) {
			return 1;
		}
	}
	return 0;
}

int check(char* str, char* typ)
{
	if (str == 0 || str[0] == '\0')
	return 1;

	char* name = find_(str);

	switch (typ[0]) {
	case 'C':
		if(!isupper(name[0])) {
			return 0;
		}
		break;
	case 'F': 
	case 'O':
		if (!islower(name[0])
			&&
			!oneOf(name[0], "_=+-!*/^%~|&<>([")
		) {
			return 0;
		}
	}
	return 1;
}

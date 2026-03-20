#include "BigInt.C"


// function for the output of the result
int test( BigInt op1, char option, BigInt op2 )
{
	if( option == '+' ) {
		BigInt res = op1 + op2;
		op1.print(); printf("+");op2.print();printf("=");
		res.print();
		printf("\n"); 
		return 1; 
	}
	else if( option == '-' ){ 
		BigInt res = op1 - op2;
        op1.print(); printf("-");op2.print();printf("=");  
        res.print();   
	printf("\n");
        return 1;
	}
	return 0; 
}

int main()
{
	printf("\n");
	BigInt a="12345";
	BigInt a1="-12345";
	BigInt b="678910";
	BigInt b1="-678910";
	BigInt c="15683201";
	BigInt c1="-111214";
	BigInt d = -47;

	BigInt e = "1";
	BigInt f = "3";
	BigInt g = "-1";
	BigInt h = "-2";
	BigInt i = "-3";
		
	test(a, '+', b1);
	test(a1, '+', b);
	test(c1, '+', c);
	test(a, '+', d);
	test(e, '+', f);

	test(g, '+', h);
	test(e, '+', i);
	test(f, '+', g);
	test(i, '+', e);
	test(g, '+', f);

	test(e, '-', f);
	test(g, '-', h);
	test(e, '-', i);
	test(f, '-', g);
	test(i, '-', e);
	test(g, '-', f);

	printf("\n");

	return (0);
}


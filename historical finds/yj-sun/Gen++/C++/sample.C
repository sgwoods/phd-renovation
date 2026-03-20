#include <stdio.h>
#include <math.h>
#include <ctype.h>

#define IN 1
#define OUT 0
#define BIG_DOUBLE 1.0E38

int calculate_average_distance( void )
{
	double a, b, c, d, t1, t2, rt;
	int rc;
	rt = 0;
	rc = 0;
	while( scanf("%1f%1f%1f%1f", &a, &b, &c, &d) != EOF )
	{
		t1 = a - c;
		t2 = b - d;
		rt += sqrt( t1*t1 + t2*t2 );
		rc ++;
	}
	printf("%f\n", rc != 0? rt/rc:0 );
	return(0);

} 

int calculate_char_word_line( void )
{
	int c, nl, nw, nc, state;
	state = OUT;
	nl = nw = nc = 0;
	while( (c=getchar()) != EOF )
	{
		++nc;
		if( c == '\n' )
			++nl;
		if( c==' ' || c=='\n' || c=='\t' )
			state = OUT;
		else if( state == OUT )
		{
			state = IN;
			++nw;
		}
	}
	printf("%d\t%d\t%d\n", nl, nw, nc );
	return 0;
}

int convert_alpha_to_int( char s[] )
{
	int i, n, sign;
	for( i=0; isspace(s[i] ); i++ )
		;
	sign = (s[i]=='-')?-1:1;
	if( s[i]=='+' || s[i]=='-' )
		i++;
	for( n=0; isdigit( s[i] ); i++ )
		n = 10*n + (s[i]-'0');
	return( sign*n );
}

int binary_search( int x, int v[], int n )
{
	int low, high, mid;
	low = 0;
	high = n-1;
	while( low <= high )
	{
		mid = (low+high)/2;
		if( x < v[mid] )
			high = mid - 1;
		else if ( x > v[mid] )
			low = mid + 1;
		else
			return mid;
	}
	return -1;
}


double calculate_minimum_distance( int a[], int b[], int n )
{
	double r, d, t1, t2;
	int j, k;
	j = 0;
	r = BIG_DOUBLE;
	while( j < n-1 )
	{
		k = j+1;
		while( k < n )
		{
			t1 = a[j] - a[k];
			t2 = b[j] - b[k];
			d = sqrt(t1 * t1 + t2 * t2 );
			if( d < r )
				r = d;
			k++;
		}
		j ++;
	}
	return r;

}  

#include <stdio.h>
#include <math.h>
#include <ctype.h>

#define BIG_DOUBLE 1.0E38

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

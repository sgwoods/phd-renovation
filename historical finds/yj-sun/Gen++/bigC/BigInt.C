#include "BigInt.h"

BigInt::BigInt(const char * digitString)// initialize the BigInt structure
{
  int n = strlen (digitString);	// set n to the digit length
  if (n != 0) {			// for non-empty digit string
    digits = new char[ndigits=n];	
    char * p = digits;
    const char * q = &digitString[n];
    while (n--) *p++ = *--q - '0';
  }
  else {				// for empty digit string
    digits = new char[ndigits=1];
    digits[0] = 0;
  }
  signMark = 0;
  if( digitString[0] == '-' )
    {
      signMark = 1;
      ndigits --;
    }
}

BigInt::BigInt(int n)			// create a BigInt from an integer
{
	char d[3*sizeof(int)+1];	// buffer of decimal digits
	char * dp = d;			// pointer to next decimal digit
	ndigits = 0;			
	int sig = (n>0)?0:1;
	n = (sig==0)?n:(-n); 
	do {				// convert integer to decimal digits 
		*dp++ = n%10;
		n/=10;
		ndigits++;
	} while (n>0);
	digits = new char[ndigits];
	register int i;
	for (i=0; i<ndigits; i++) {
		digits[i] = d[i];
	}
	signMark = 0;			// set in a sign checker`
	if( sig == 1 )
	{
		signMark = 1;		// if negative number, ignore sign
	}
}

BigInt::BigInt(const BigInt &n)		// copy the value of the BigInt 
					// argument into a new instance
					// of BigInt.
{
	int i = n.ndigits;
	signMark = n.signMark; 
	digits = new char[ndigits=i];
	char* p = digits;
	char* q = n.digits;
	while (i--) *p++ = *q++;
}

BigInt BigInt::operator+ (BigInt& n){ // implement BigInt addition
  int maxDigits = (ndigits>n.ndigits ? ndigits : n.ndigits) + 1;
  char* sumPtr = new char[maxDigits]; 	// allocate storage for sum
  BigInt sum(sumPtr, maxDigits);		
  BigInt op1(*this);
  BigInt op2(n);

  DigitStream a(*this);
  DigitStream b(n);

  if( a.get_sign() == 0 && b.get_sign() == 0 ){ // check for two positve
    sum.signMark = 0;				// integers' addition
    int i = maxDigits;
    int carry = 0;
    while (i--) {
      *sumPtr = (a++) + (b++) + carry;  // addition with carry
      // with next digit of this*
      // and next digit of n*
      if (*sumPtr > 9) {
	carry = 1;
	*sumPtr -= 10;
      }
      else carry = 0;
      sumPtr++;
    }
    return sum;
  }
  else if( a.get_sign() == 1 && b.get_sign() == 1 ){ // check for two 
    sum.signMark = 1;				// negative integers
    int i = maxDigits;
    int carry = 0;
    while (i--) {
      *sumPtr = (a++) + (b++) + carry;  // addition with carry
      // with next digit of this*
      // and next digit of n*
      if (*sumPtr > 9) {
	carry = 1;
	*sumPtr -= 10;
      }
      else carry = 0;
      sumPtr++;
    }
    return sum;
  }
  
  else if( a.get_sign() == 0 && b.get_sign() == 1) { // check for two 
    op2.signMark = 0;				// integers, first of which
    return op1-op2;				// is positive, and the other
  } 						// is negative

  else if( a.get_sign() == 1 && b.get_sign()==0 ){  // check for the first
    op1.signMark = 0;				// one negative and the other
    return op2-op1;				// positive
  }
}

int BigInt :: compare(const BigInt& b){		// compare two integers
  char *p = digits+ndigits-1;
  char *q = b.digits+b.ndigits-1;
  int n = ndigits;

  if (ndigits > b.ndigits)			// if the first one is bigger
    return 1;					// return 1;
  else if(ndigits < b.ndigits)			// otherwise, return 0
    return 0;
  else {
    while (*p-- == *q-- && n >= 0) n--;
    if( *++p < *++q )
      return 0;
    else
      return 1;
  }
}

BigInt BigInt::operator- (BigInt& n){ // implement BigInt addition
  int maxDigits = (ndigits>n.ndigits ? ndigits : n.ndigits);
  char* diffPtr = new char[maxDigits]; 	// allocate storage for diff
  BigInt diff(diffPtr, maxDigits);		
  int i = maxDigits;
  int borrow = 0;
  char tmp1, tmp2;
  
  BigInt op1(*this), op2(n);
  
  if( op1.signMark == 0 && op2.signMark == 0 ) { // check for two positive
    if (compare(n)){  				// integers' subtraction
      diff.signMark = 0;			// |op1| > |op2|
      DigitStream a(op1);
      DigitStream b(op2);
      while (i--) {
	tmp1 = a++;
	tmp2 = b++;
	tmp1 -= borrow;
	if (tmp1 < tmp2){
	  tmp1 += 10;
	  borrow = 1;
	}
	else borrow = 0;
	*diffPtr = tmp1 - tmp2;
	diffPtr++;
      }
    }
    else {					// |op2| > |op1|
      diff.signMark = 1;
      DigitStream b(op1);
      DigitStream a(op2);
      while (i--) {
	tmp1 = a++;
	tmp2 = b++;
	tmp1 -= borrow;
	if (tmp1 < tmp2){
	  tmp1 += 10;
	  borrow = 1;
	}
	else borrow = 0;
	*diffPtr = tmp1 - tmp2;
	diffPtr++;
      }
    } 
  }

  if( op1.signMark == 0 && op2.signMark == 1 ) { // check for 
    op2.signMark = 0;				// op1 >= 0, op2 < 0
    return op1 + op2;
  }

  if( op1.signMark == 1 && op2.signMark == 0 ) { // op1 < 0, op2 >= 0
    op2.signMark = 1;
    return op1+op2;
  }
  if( op1.signMark == 1 && op2.signMark == 1 ) { // op1 < 0, op2 < 0
    if (compare(n)){  				// |op1| >= |op2|
      diff.signMark = 1;
      DigitStream a(op1);
      DigitStream b(op2);
      while (i--) {
	tmp1 = a++;
	tmp2 = b++;
	tmp1 -= borrow;
	if (tmp1 < tmp2){
	  tmp1 += 10;
	  borrow = 1;
	}
	else borrow = 0;
	*diffPtr = tmp1 - tmp2;
	diffPtr++;
      }
    }
    else {					// |op1| < |op2|
      diff.signMark = 0;
      DigitStream b(op1);
      DigitStream a(op2);
      while (i--) {
	tmp1 = a++;
	tmp2 = b++;
	tmp1 -= borrow;
	if (tmp1 < tmp2){
	  tmp1 += 10;
	  borrow = 1;
	}
	else borrow = 0;
	*diffPtr = tmp1 - tmp2;
	diffPtr++;
      }
    } 
  }
  return diff;
}


void BigInt::print()			// print function	
{
	int i;
	if( signMark == 1 )
	{
		printf("(");
	    printf("-");
	}
	for (i=ndigits-1; i>=0; i--)
	printf("%d", digits[i]);
	if( signMark == 1 )
	printf(")"); 
}










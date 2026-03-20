#ifndef BigInt_h			// To avoid duplicate include.
#define BigInt_h

#include <iostream.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


class BigInt {
  char * digits;			// pointer to digit array. 
  int ndigits;			// number of digits.
  int signMark;
  BigInt(char * d, int n) {	// constructor function.
    digits = d;
    
  ndigits = n;
  }
friend class DigitStream;
  
public:
  BigInt(const char *);		// constructor function
  BigInt(int);			// constructor function
  BigInt(const BigInt&);		// initialize constructor function
  ~BigInt() { delete digits; }; 	// destructor function
  int compare(const BigInt& );
  BigInt operator- (BigInt&); // subtraction operator function
  BigInt operator+ (BigInt&); // addition operator function
  void print();			// printing function
};

class DigitStream {
  char * dp;			// pointer to cuttent digit
  int nd;				// number of digits remaining
  int sign;
public:
  DigitStream(const BigInt& n) {	// constructor function
    dp = n.digits;
    nd = n.ndigits;
    sign = n.signMark;
  }
  int get_sign(){return sign;}
  int operator++() {		// return current digit and advance
    if (nd == 0) return 0;
    else {
      nd--;
      return *dp++;
    }
  }
};
	
#endif


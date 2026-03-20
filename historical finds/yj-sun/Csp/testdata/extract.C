#include <iostream.h>
#include <iomanip.h>
#include <fstream.h>

#include <string.h>

const int MAX = 50;

main(int argc, char* argv[])
{
  const int factor = 5;
  const int level = 6;
  const int total = 76;

  int data[level][MAX];
  double avg[level];
  int count = 0;
  int i, j;
  int tempint, tmpmin, tmpmax;

  double tempdouble;
  char tempstring[100];

  ifstream infile(argv[1], ios::in);

  for(i=0; i<level; i++ )
    for(j=0; j<factor*i + (i==0?1:0); j++ )
      {
	do {
	  infile>>tempstring; 
	} while ( strcmp( tempstring, "DEFAULT") != 0 );
	infile>>tempdouble;
	infile>>tempint;
	infile>>data[i][j];
      }

   for(i=0; i<level; i++ )
   {
     tmpmin = data[i][0]; tmpmax = data[i][0];
     avg[i] = 0;
     for(j=0; j<factor*i + (i==0?1:0); j++ )
      {
	avg[i] += data[i][j];
	if( tmpmin > data[i][j] )
	  tmpmin = data[i][j];
	if( tmpmax < data[i][j] )
	  tmpmax = data[i][j];
      }
     avg[i] /= (factor*i+(i==0?1:0));
     data[i][j] = tmpmin; data[i][j+1] = tmpmax;
   }

   for(i=0; i<level; i++ )
     {
       j=factor*i + (i==0?1:0);
       cout<<data[i][j]<<endl;
     }
   cout<<endl<<endl;

   for(i=0; i<level; i++ )
     {
       j=factor*i + (i==0?1:0);
       cout<<data[i][j+1]<<endl;
     }
   cout<<endl<<endl;

   for(i=0; i<level; i++ )
     {
       cout<<int(0.5+avg[i])<<endl;
     }
   cout<<endl<<endl;

}

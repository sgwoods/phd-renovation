//statis.h
//To compute the final grade for EE467 Spring 1996.
//Yongjun Zhang 

#include </usr/lang/SC2.0.1/include/CC_411/iostream.h>
#include </usr/lang/SC2.0.1/include/CC_411/iomanip.h>
#include </usr/lang/SC2.0.1/include/CC_411/fstream.h>


const int MAX = 10;

class Grade {
	char  name[20];  
	char	ssn[15];
	int	grade[MAX];
	int finalGrade;

	friend class GradeTable;
};

class GradeTable {

	Grade* studentSet;
	int numOfStudents;
	int numOfGrade;

	double percentage[MAX];

public:

	GradeTable( int numberOfStudent, double* per, int numGrade=6 );
	~GradeTable() { delete [] studentSet; };
	void ReadDataFromFile( char* fileName );
	void ComputeFinalGrade();
	void PrintOutResult(int name = 0, int ssnumber = 1);

};



//statis.C
//Yongjun Zhang

GradeTable::GradeTable(int numberOfStudent, double *per, int numGrade)
{
  numOfStudents = numberOfStudent;
  numOfGrade = numGrade;
  
  for( int i=0; i<numOfGrade; i++)
    percentage[i] = per[i];
  
  studentSet = new Grade[numOfStudents]; 
	
}


void GradeTable::ReadDataFromFile( char* fileName )
{
  ifstream infile( fileName, ios::in );
  
  char Escape[20];
  int i, j;
  
  if( !infile )
    {
      cerr<<"Cannot open file."<<endl;
      exit(0);
	}
  
  //escape the first line which indicate item type
  for( i=0; i< numOfGrade+2; i++ )
    {
      infile>>Escape;
    }
	for(i=0; i<numOfStudents; i++ )
	  {
	    infile>>studentSet[i].name;
	    infile>>studentSet[i].ssn;
	    
	    for(j=0; j<numOfGrade; j++ )
	      infile>>studentSet[i].grade[j];
	  }
	
} 


void GradeTable::ComputeFinalGrade()
{
  double temp;
  
  for( int i=0; i<numOfStudents; i++ )
    {
      temp = 0; 	
      for( int j=0; j<numOfGrade; j++ )
	temp += percentage[j] * studentSet[i].grade[j];
      studentSet[i].finalGrade = (int) ( 0.5 + temp);
    }
}

void GradeTable::PrintOutResult(int name, int ssnumber )
{
  
  int i, j;
  int width = 8;
  if( name == 0 )
    {
      
      cout.fill(' ');
      cout.setf(ios::right, ios::adjustfield);
      cout<<setw(width)<<"SSN";
      cout<<setw(width+4)<<"FinalGrade\n";
      cout<<"=====================================================================\n";
      for( i=0; i<numOfStudents; i++ )
	{ 
	  
	  cout<<setw(width)<<studentSet[i].ssn;

	  if ( studentSet[i].finalGrade >= 89 )
		cout<<setw(width)<<"      A";

	  else if ( studentSet[i].finalGrade >= 79 )
		cout<<setw(width)<<"      B";

	  else if ( studentSet[i].finalGrade >= 70 )
		cout<<setw(width)<<"      C";

	  else
		cout<<setw(width)<<"      D";
	  cout<<endl;
	  
	}			
    }
  else if ( name == 1 )
    {

      cout.fill(' ');
      cout.setf(ios::right, ios::adjustfield);
      cout<<setw(width)<<"Name";
      cout<<setw(width)<<"SSN";
      cout<<setw(width)<<"PRJ1";
      cout<<setw(width)<<"PRJ2";
      cout<<setw(width)<<"PRJ3";
      cout<<setw(width)<<"PRJ4";
      cout<<setw(width)<<"PRJ5";
      cout<<setw(width)<<"FPRJ";
      cout<<setw(width+4)<<"FinalGrade\n";
      cout<<"==========================================================================\n";
      for( i=0; i<numOfStudents; i++ )
	{ 
	  cout<<setw(width)<<studentSet[i].name; 
	  cout<<setw(width)<<studentSet[i].ssn;
	  for( j=0; j<numOfGrade; j++ )
	    {
		cout.setf(ios::right, ios::adjustfield);
		cout<<setw(width)<<studentSet[i].grade[j];
	    }
	  
	  cout<<setw(width)<<studentSet[i].finalGrade;

	  if ( studentSet[i].finalGrade >= 89 )
		cout<<setw(width)<<"      A";

	  else if ( studentSet[i].finalGrade >= 79 )
		cout<<setw(width)<<"      B";

	  else if ( studentSet[i].finalGrade >= 70 )
		cout<<setw(width)<<"      C";

	  else
		cout<<setw(width)<<"      D";
	  cout<<endl;
	  
	}			
    }
}
  
  
main( int argc, char *argv[] )
{

	double percentage[6] = {0.05, 0.05, 0.05, 0.30, 0.20, 0.35 };

	if( argc != 2 )
	{
		cout<<"Usage: "<<argv[0]<<"  inputfile"<<endl;
		exit(0);
	}

	GradeTable gradeTable(30, percentage, 6);
	gradeTable.ReadDataFromFile( argv[1] );

	gradeTable.ComputeFinalGrade();

	gradeTable.PrintOutResult(1); 


}
  
  
  
  
		 

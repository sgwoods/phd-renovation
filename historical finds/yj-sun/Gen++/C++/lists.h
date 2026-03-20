#ifndef _LIST_H
#define _LIST_H

//#include </usr/lang/SC2.0.1/include/CC_411/iostream.h>

#define BOOLEAN short
#define SUCCESS 1
#define FAIL 0
#define TRUE 1
#define FALSE 0


typedef int  itemType;

struct node {
  node *next;
  itemType item;
};

class List{
 
 protected:
  node *first, *last;//ptrs to front/back
  int items;//number of values
 public:
  List() {
    first = last = 0; items = 0;
  }
  ~List();
  void insert_front( itemType value );
  void insert_rear( itemType value ); 
  int isempty() { return first == 0; }
  int length() { return items; }
  int in_list( itemType value );
  itemType remove( int index ); 
//  friend ostream& operator<<(ostream& output, const List &l);
};

#endif

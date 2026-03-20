
#include "lists.h" 

List::~List()
{
  node *ptr;
  for( ptr = first; ptr !=0; ptr=ptr->next )
    delete ptr;
  items = 0;
  first = last = 0;
}

void List::insert_front( itemType value ) 
{
  node *temp = new node; 
  temp->next = first; //create and fill node
  temp->item = value;
  first = temp; //hook into list
  if( !last ) //only last in empty
      last = temp;

  items++; //increase number of nodes

}

void List::insert_rear( itemType value ) 
{

  if( !first )
    insert_front( value );
  else {
    if( items == 1 )
      first = last; 
    node *temp = new node; 
    temp->next = 0; //create and fill node
    temp->item = value;
    last->next = temp; //hook into list   
    last = temp; 

    items++; //increase number of nodes

  }
}

int List::in_list( itemType value )
{
  node *tmp = first;
  int len = 0;
  while(  len < items ){
    if( value == tmp->item )
      return len;
    tmp = tmp->next;
    len ++;
  }
  return -1; 

}

itemType List::remove( int index)
{
  node *tmp = first, *tmp1;
  itemType retvalue; 
  int len = 0;
  if( items == 0 || index < 0 || index > items-1 )
    return -1; 
  if( items == 1 ){
    retvalue = first->item;
    first = last = 0;
    items = 0;
    delete tmp;
    return retvalue;
  }

  while(  len < index-1 ){
    tmp = tmp->next;
    len ++;
  }
  if( index == 0 ){
    tmp1 = first;
    retvalue = tmp1->item; 
    first = first->next;
    delete tmp1;
  }
  else if( index < items-1 ){
    tmp1 = tmp->next;
    retvalue = tmp1->item; 
    tmp->next = tmp1->next;
    delete tmp1;
  }
  else {
    retvalue = last->item; 
    delete last;
    tmp->next = 0;
    last = tmp;  
  }
  items --;  
  return retvalue; 
}
/*
itemType List::remove( int index)
{
  node *tmp = first, *tmp1;
  itemType retvalue; 

  tmp1 = first;
  retvalue = tmp1->item; 
  first = first->next;
  if( items == 1 )
    first = last = 0; 
  delete tmp1;
  items --;  
  return retvalue;     
}
*/
/*ostream& operator<<( ostream& output, const List &l) 
{
  node *ptr;

  for( ptr = l.first; ptr != 0; ptr = ptr->next )
    output << ptr->item << " ";
  output << "\n"; 
  return output;
}
*/

     1
     2  #include "lists.h"
     3
     4  List::~List()
     5  {
     6    node *ptr;
     7    for( ptr = first; ptr !=0; ptr=ptr->next )
     8      delete ptr;
     9    items = 0;
    10    first = last = 0;
    11  }
    12
    13  void List::insert_front( itemType value )
    14  {
    15    node *temp = new node;
    16    temp->next = first; //create and fill node
    17    temp->item = value;
    18    first = temp; //hook into list
    19    if( !last ) //only last in empty
    20        last = temp;
    21
    22    items++; //increase number of nodes
    23
    24  }
    25
    26  void List::insert_rear( itemType value )
    27  {
    28
    29    if( !first )
    30      insert_front( value );
    31    else {
    32      if( items == 1 )
    33        first = last;
    34      node *temp = new node;
    35      temp->next = 0; //create and fill node
    36      temp->item = value;
    37      last->next = temp; //hook into list
    38      last = temp;
    39
    40      items++; //increase number of nodes
    41
    42    }
    43  }
    44
    45  int List::in_list( itemType value )
    46  {
    47    node *tmp = first;
    48    int len = 0;
    49    while(  len < items ){
    50      if( value == tmp->item )
    51        return len;
    52      tmp = tmp->next;
    53      len ++;
    54    }
    55    return -1;
    56
    57  }
    58
    59  itemType List::remove( int index)
    60  {
    61    node *tmp = first, *tmp1;
    62    itemType retvalue;
    63    int len = 0;
    64    if( items == 0 || index < 0 || index > items-1 )
    65      return -1;
    66    if( items == 1 ){
    67      retvalue = first->item;
    68      first = last = 0;
    69      items = 0;
    70      delete tmp;
    71      return retvalue;
    72    }
    73
    74    while(  len < index-1 ){
    75      tmp = tmp->next;
    76      len ++;
    77    }
    78    if( index == 0 ){
    79      tmp1 = first;
    80      retvalue = tmp1->item;
    81      first = first->next;
    82      delete tmp1;
    83    }
    84    else if( index < items-1 ){
    85      tmp1 = tmp->next;
    86      retvalue = tmp1->item;
    87      tmp->next = tmp1->next;
    88      delete tmp1;
    89    }
    90    else {
    91      retvalue = last->item;
    92      delete last;
    93      tmp->next = 0;
    94      last = tmp;
    95    }
    96    items --;
    97    return retvalue;
    98  }
    99  /*
   100  itemType List::remove( int index)
   101  {
   102    node *tmp = first, *tmp1;
   103    itemType retvalue;
   104
   105    tmp1 = first;
   106    retvalue = tmp1->item;
   107    first = first->next;
   108    if( items == 1 )
   109      first = last = 0;
   110    delete tmp1;
   111    items --;
   112    return retvalue;
   113  }
   114  */
   115  /*ostream& operator<<( ostream& output, const List &l)
   116  {
   117    node *ptr;
   118
   119    for( ptr = l.first; ptr != 0; ptr = ptr->next )
   120      output << ptr->item << " ";
   121    output << "\n";
   122    return output;
   123  }
   124  */


digraph hier {
node [shape=ellipse];
 page="8.5,11";
margin="0.1,0.1";
fontsize= 6

 Statement6 -> "Statement7";
 
"Statement7 Return" [shape=box];

"Statement7" -> "Statement7 Return" ;

 "printf@Statement15" [shape=box];

 "Statement15" -> "printf@Statement15" [label=call] ;

 "printf@Statement15" -> "Statement18" [label=return] ;

"Statement13 then" -> "Statement15" ;

 "Statement13" -> "Statement13 then"[label = "argc< 1 " ];

 "Statement13" -> "Statement18"[style = dotted, label = "NOT (argc< 1 )" ];

 Statement18 -> "Statement19";
 
 Statement19 -> "Statement21";
 
 Statement21 -> "Statement23";
 
 Statement23 -> Statement25;
 
 Statement23 -> Statement29;
 
 Statement23 -> Statement42;
 
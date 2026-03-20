/*
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
*/

struct sockaddr_in {
	short	sin_family;
	unsigned short	sin_port;
	struct	in_addr sin_addr;
  char	sin_zero[8]; };

struct in_addr {
	union {
		struct { unsigned char s_b1, s_b2, s_b3, s_b4; } S_un_b;
		struct { unsigned short s_w1, s_w2; } S_un_w;
		unsigned long S_addr;
	} S_un;
}

main( int argc, char **argv ) {
  int fdSocket, fdNew;
  struct sockaddr_in sain, sainClient;
  char rgcMsg[256];
  int iAddr_len, iBytes;

  fdSocket = socket( AF_INET, SOCK_STREAM, 0 );
  
  if( fdSocket < 0 ) {
    perror( "socket failed" );
    return( -1 );
  }

  memset( (void *)&sain, 0, sizeof( sain ) );
  sain.sin_family = AF_INET;
  sain.sin_addr.s_addr = INADDR_ANY;
  sain.sin_port = htons( 8181 );

  if( bind( fdSocket, (struct sockaddr *)&sain, sizeof( sain ) ) < 0 ) {
    perror( "bind failed" );
    close( fdSocket );
    return( -1 );
  }
 
  if( listen( fdSocket, 1 ) < 0 ) {
    perror( "listen failed" );
    close( fdSocket );
    return( -1 );
  }

  for( ;; ) {
    if( (fdNew = accept( fdSocket, (struct sockaddr *)&sainClient, &iAddr_len)) < 0 ) {
      perror( "accept failed" );
      close( fdSocket );
      return( -1 );
    }
    
    while( (iBytes = recv( fdNew, rgcMsg, 256, 0 )) > 0 ) {
      rgcMsg[iBytes] = 0;
      printf( "%s\n", rgcMsg );
    }
  }
}

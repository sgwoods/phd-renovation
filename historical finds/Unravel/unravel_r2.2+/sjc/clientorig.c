/*
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
*/

struct hostent {
  unsigned char h_addr;
};

struct in_addr {
  unsigned long s_addr;
};

struct sockaddr_in {
  short	   sin_family;
  unsigned short sin_port;
  struct   in_addr sin_addr;
  char	   sin_zero[8];
 };

#define MAX_LEN		4096

main( int argc, char **argv ) {
  int fdSocket;
  struct sockaddr_in sain;
  char acRequest[256];
  char *szResponse;
  int iBytes;
  int iPage_pointer = 0;
  struct hostent *phe;
  char *szHost = argv[1], rgcAddr[256];

  char *fn1( struct hostent pheparam, char* fred );

  /*  printf( "%s\n", szURLptr ); */

  fdSocket = 3;

  fdSocket = socket( AF_INET, SOCK_STREAM, 0 );
  
  if( fdSocket < 0 ) {
    perror( "socket failed" );
    return( -1 );
  }

  phe = gethostbyname( szHost );
  if( phe == NULL ) {
    perror( "gethostbyname failed" );
    exit( -1 );
  }

  memset( (void *)&sain, 0, sizeof( sain ) );
  sain.sin_family = AF_INET;

  /*
  sprintf( rgcAddr, "%ld.%ld.%ld.%ld", 
	   *((unsigned char *)(&phe->h_addr[0])),
	   *((unsigned char *)(&phe->h_addr[1])),
	   *((unsigned char *)(&phe->h_addr[2])),
	   *((unsigned char *)(&phe->h_addr[3])) );
	   */
  fn1( phe, rgcAddr ); /* rgcAddr depends on phe */

  sain.sin_addr.s_addr = inet_addr( rgcAddr );
  sain.sin_port = htons( 8181 );

  if( connect( fdSocket, (struct sockaddr *)&sain, sizeof( sain ) ) < 0 ) {
    perror( "connect failed" );
    close( fdSocket );
    return( -1 );
  }

  send( fdSocket, argv[2], strlen( argv[2] ), 0 );

  close( fdSocket );
}

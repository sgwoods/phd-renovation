YFLAGS	= -dv
CFLAGS	= -O
LFLAGS	=

BIN 	= /u/sgwoods/bin
SRC	= gram.y scan.l main.c
OBJ	= gram.o scan.o main.o

CC	= /usr/ucb/cc
#CC	= /usr/bin/cc
#CC	= gcc

$(BIN)/ansi_c :	$(OBJ)
	${CC} $(CFLAGS) $(OBJ) -o $(BIN)/ansi_c

scan.o	: y.tab.h

clean	:
	rm -f y.tab.h y.output *.o

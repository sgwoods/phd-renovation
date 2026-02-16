# Makefile 
# 
# grab.c
#

CC=gcc

FLAGS= -g -DXSDEBUG 

grab:		grab.o
		$(CC) -o grab grab.o


grab.o:		grab.c 
		$(CC) -c $(FLAGS) grab.c

grab-ci:	grab-ci.o
		$(CC) -o grab-ci grab-ci.o -lm


grab-ci.o:	grab-ci.c 
		$(CC) -c $(FLAGS) grab-ci.c
grab-ci-time:	grab-ci-time.o
		$(CC) -o grab-ci-time grab-ci-time.o -lm


grab-ci-time.o:	grab-ci-time.c 
		$(CC) -c $(FLAGS) grab-ci-time.c

grabit:		grabit.o
		$(CC) -o grabit grabit.o


grabit.o:	grabit.c 
		$(CC) -c $(FLAGS) grabit.c

sread:		sread.o
		$(CC) -o sread sread.o


sread.o:	sread.c 
		$(CC) -c $(FLAGS) sread.c


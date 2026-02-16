#	$Id: Makefile.tetravect,v 1.7 1995/06/26 17:34:09 npkonrad Exp $	
#
# Makefile for tetravect
#

AVS_PATH=/p/scivis/avs-$(ARCH)
INC_FILE=$(AVS_PATH)/include/Makeinclude
include $(INC_FILE)

AVS_LIBS = $(AVS_PATH)/lib
INC = $(AVS_PATH)/include
BASELIBS=-lgeom -lutil -lm $(LASTLIBS)
CFLAGS = -I$(INC) $(AOPTCFLAGS) $(LOCAL_CFLAGS) $(G)
CFLOWLIBS=-L$(AVS_LIBS) -lflow_c $(BASELIBS)
CSIMLIBS=-L$(AVS_LIBS) -lsim_c $(BASELIBS)

OBJPATH = Object/$(ARCH)
SOURCE = tetravect.c cell_trans.c cell_connect.c \
	 matrix.c particle.c advance.c mapper.c \
	 init_data.c cell_ops.c init_particles.c \
	random_cells.c
OBJECT = $(OBJPATH)/tetravect.o $(OBJPATH)/cell_trans.o		\
	$(OBJPATH)/cell_connect.o $(OBJPATH)/matrix.o		\
	$(OBJPATH)/particle.o $(OBJPATH)/advance.o	\
	$(OBJPATH)/mapper.o $(OBJPATH)/init_data.o	\
	$(OBJPATH)/cell_ops.o $(OBJPATH)/init_particles.o	\
	$(OBJPATH)/random_cells.o
EXECUTABLE = $(OBJPATH)/tetravect

tetravect:	$(OBJECT)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(OBJECT) $(CSIMLIBS)
	rm tetravect
	ln -f -s $(EXECUTABLE) tetravect

$(OBJPATH)/tetravect.o:	tetravect.c cell_trans.h cell_connect.h particle.h init_data.h
	$(CC) $(CFLAGS)  -c tetravect.c -o $@

$(OBJPATH)/cell_trans.o: cell_trans.c cell_trans.h matrix.h
	$(CC) $(CFLAGS) -c cell_trans.c -o $@
	
$(OBJPATH)/cell_connect.o: cell_connect.c cell_connect.h
	$(CC) $(CFLAGS) -c cell_connect.c -o $@
	
$(OBJPATH)/matrix.o:	matrix.c matrix.h
	$(CC) $(CFLAGS) -c matrix.c -o $@
	
$(OBJPATH)/particle.o:	particle.c particle.h
	$(CC) $(CFLAGS) -c particle.c -o $@

$(OBJPATH)/advance.o: advance.c cell_trans.h cell_connect.h particle.h init_data.h
	$(CC) $(CFLAGS) -c advance.c -o $@

$(OBJPATH)/mapper.o: mapper.c mapper.h cell_trans.h particle.h map_shapes.h
	$(CC) $(CFLAGS) -c mapper.c -o $@

$(OBJPATH)/init_data.o: init_data.c init_data.h
	$(CC) $(CFLAGS) -c init_data.c -o $@

$(OBJPATH)/cell_ops.o: cell_ops.c cell_ops.h particle.h
	$(CC) $(CFLAGS) -c cell_ops.c -o $@

$(OBJPATH)/init_particles.o: init_particles.c init_particles.h advance.h random_cells.h
	$(CC) $(CFLAGS) -c init_particles.c -o $@

$(OBJPATH)/random_cells.o: random_cells.c random_cells.h
	$(CC) $(CFLAGS) -c random_cells.c -o $@

tetravect.i:
	$(CC) $(CFLAGS) -P tetravect.c

advance.i:
	$(CC) $(CFLAGS) -P advance.c

clean:
	rm $(OBJECT) $(EXECUTABLE)
	
tags:
	etags $(SOURCE)

#
#  The following rules define the procedure for building tetravect using
#  the c++ compiler.
#
#
CPPFLAGS = -I$(INC) $(AOPTCFLAGS) $(LOCAL_CFLAGS) $(G)

CPP_OBJPATH = CppObj/$(ARCH)
CPP_OBJ = $(CPP_OBJPATH)/tetravect.o

# Add the following to CPP_OBJ as we check that they compile properly
#	$(CPP_OBJPATH)/cell_trans.o		\
#	$(CPP_OBJPATH)/cell_connect.o $(CPP_OBJPATH)/matrix.o		\
#	$(CPP_OBJPATH)/particle.o $(CPP_OBJPATH)/advance.o	\
#	$(CPP_OBJPATH)/mapper.o $(CPP_OBJPATH)/init_data.o	\
#	$(CPP_OBJPATH)/cell_ops.o $(CPP_OBJPATH)/init_particles.o	\
#	$(CPP_OBJPATH)/random_cells.o

CPP_EXEC = $(CPP_OBJPATH)/tetravect

cplusplus:	$(CPP_OBJ)
	cpp $(CFLAGS) -o $(CPP_EXEC) $(CPP_OBJ) $(CSIMLIBS)
	rm tetravect
	ln -f -s $(CPP_EXEC) tetravect

$(CPP_OBJPATH)/tetravect.o:	tetravect.c cell_trans.h cell_connect.h \
				particle.h init_data.h
	cpp $(CFLAGS)  -c tetravect.c -o $@


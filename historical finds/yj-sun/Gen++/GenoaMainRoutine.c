

/*===================================================================================*/
/* This product produced by sgwoods on Thu Oct  9 14:51:49 1997 from file                     */
/*    /tmp_mnt/proj/seg/team/sgwoods/yj-sun/Gen++/myquery/compound-contain.query using   */   

/* the gen++ applications generator, Unknown version                        */
/*                                                                                   */
/*  The gen++ applications Generator was written by Prem Devanbu,                 */
/* of the Artificial Intelligence principles Research Department,                    */
/* in collaboration with Laura Eaves of the Object Oriented Technologies group */
/* AT&T Bell Labs. Murray Hill, Telno (201) 582-2062, prem@research.att.com          */
/*===================================================================================*/




/*--------------*/
/* FIXED STUFF  */
/*--------------*/

#include  "Gmainheader.h"
#include  "glistops.h"

#include  "gexpand.h"
#include  "gunparse.h"
#ifdef FUNCTABLE
#include "ExtFEhdr.h"
#endif

extern AXS_HEAD NodeTable[];

/* PD *phead,ptmp;
VD *vtmp; */



/******************************************/
/****** Application Specific Stuff ********/
/******************************************/                                            
GNODE slog;                                            
GNODE control;                                            
GNODE component;     


typedef int INTEGER;
typedef char *STRING;
typedef float FLOAT;


#if __STDC__ || __cplusplus
  void G_initialize();
  void FileFlow (GNODE);
  char *GetTheOpt(char**,int,int,char*);
  char *GetTheEnv(int,char*);
  GNODE  _G_Initializer(int,char**);
 void _G_Finalizer(GNODE);
#else
  void G_initialize();
  void FileFlow () ;
#ifdef  _G_HAS_INITIALIZER
  GNODE  _G_Initializer();  
#endif
#ifdef _G_HAS_FINALIZER
  void  _G_Finalizer();  
#endif
  char *GetTheOpt();
  char *GetTheEnv();
#endif
GNODE fileName;
GNODE fname;
GNODE finish_stmt;


#if __STDC__ || __cplusplus
GenoaMainRoutine(void *ExtRoot)
#else
GenoaMainRoutine(ExtRoot)
void *ExtRoot;
#endif
{
	GNODE Root = (GNODE) gmalloc ();
slog = gmalloc();
slog->node_flag = (GSIMPLENODE | GBUILTIN);
slog->node_type = C_File;

if ((slog->node_data.l_dv = (char *) fopen("statementInBody","w")) ==  NULL)  {
	fprintf(stderr,"\nFATAL ERROR **********Cannot open (or create, if output) File statementInBody **********!!!\n");
	exit(1);
	}




	G_initialize();
#ifdef  _G_HAS_INITIALIZER_
 	Root = _G_Initializer(argc,argv); 
#endif
        Root->node_type = _G_ROOTTYPE;
	Root->gparent = (GNODE) NULL;
	Root->node_flag = GSIMPLENODE;
	Root->node_data.l_dv = ExtRoot;
   FileFlow (Root);
#ifdef _G_HAS_FINALIZER
	_G_Finalizer(Root);	
#endif                                            
        fclose((FILE *) slog->node_data.l_dv);                                            
        fclose((FILE *) control->node_data.l_dv);                                            
        fclose((FILE *) component->node_data.l_dv);     
return;

}

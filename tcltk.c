/*
 Copyright (C) 1999 Guido Masarotto

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include "tk.h"

void   tk_eval(char **cmd);
void   tk_eventloop();
void   tk_reset();
void   tk_frontend(void *f); 

static Tcl_Interp *interp = NULL;
static int ProcessingEvents = 0;
static int    RCmd(ClientData cd,Tcl_Interp *interp,int argc,char *argv[]);
static void tcl_begin();

void tk_eval(char **cmd) {
  if(!interp) tcl_begin();
  if (Tcl_Eval(interp,*cmd)==TCL_ERROR) {
       char p[512];
       if (strlen(interp->result)>500)
         strcpy(p,"tcl error.\n");
       else
         sprintf(p,"[tcl] %s.\n",interp->result); 
       error(p);
  }
  *cmd = interp->result;
}

void tk_eventloop() {
  char s[8]="update";
  if (!interp) error("[tcl] No active interpreter.");
  ProcessingEvents = 1;
  while (ProcessingEvents) Tk_DoOneEvent(TK_ALL_EVENTS);
  Tcl_Eval(interp,s);
}  
  



void tk_reset() {
   if (!interp) return; 
   Tcl_Finalize();
   interp = NULL;
}



static void tcl_begin() {
    char s[128];
    if (!(interp = Tcl_CreateInterp()))
         error("[tcl] Impossible to  create the tcl interpreter.\n");     
    if (Tcl_Init(interp)==TCL_ERROR) {
         tk_reset();
         error("[tcl] Impossible start tcl.\n"); 
    }
    if (Tk_Init(interp)==TCL_ERROR) {
         tk_reset();
         error("[tcl] Impossible to add tk to the tcl interpreter.\n");
    }
    Tcl_StaticPackage(interp, "Tk", Tk_Init, Tk_SafeInit);  
    Tcl_CreateCommand(interp,"R",RCmd,NULL,NULL);
    /* Avoid to use a constant string in Tcl_Eval */
    strcpy(s,"proc exit args {R -stop}");
    Tcl_Eval(interp,s);
    strcpy(s,"set argc 1; set argv R");
    Tcl_Eval(interp,s);
}




/* A minimal interface; only for side effects in R*/
void call_S(char *func, long nargs, void **arguments, char **modes,
            long *lengths, char **names, long nres, char **results);   

static void *func = NULL;
void tk_frontend(void *f) {
  func = f;
}



static int RCmd(ClientData cd,Tcl_Interp *i,int argc,char *argv[]) {
  void *arguments[1];
  char *modes[1];
  long lengths[1];
  if (argc<2) return TCL_OK;
  if ((argc==2) && !strcmp(argv[1],"-stop")) {
     strcpy(i->result,"");
     ProcessingEvents = 0;
     return TCL_OK;
  } 
  if (!func) { 
    strcpy(i->result,"I don't know yet how to evaluate a R expression.");
    return TCL_ERROR;
  }
  arguments[0] = (void *) Tcl_Concat(argc-1,&argv[1]);
  modes[0] = "character";
  lengths[0] = 1;
  Tcl_Preserve(arguments[0]);
  call_R(func,1L,arguments,modes,lengths,NULL,0,NULL);  
  Tcl_Release(arguments[0]);
  strcpy(i->result,"");
  return TCL_OK;
}

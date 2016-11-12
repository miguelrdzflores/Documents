#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mpi.h"
#include "palmlibc.h"
#include "tool_verb.h"
int f2c_name(if_ppalm_branches_instructions)(int, int);
extern void f2c_name(pl_debug)(int*,char*,int*,char*,int*,int*,int*,int*,void*);

int if_ppalm_set_debug_fct() {
  pvf_debug=&f2c_name(pl_debug);
  return 0;
}
int if_drv_tube_compute_partno(const int id_putdlrk, const int id_getdlrk, 
			       const int id_tubeidx) {

  printf("ERROR !!! if_drv_tube_compute_partno not allowed in entities\n");
  return(99);
}


char* ppalm_branch_name(int id_index) {
  switch (id_index)
     {
          case 0: return "b1"; break ; 
     }
  return "0";
}

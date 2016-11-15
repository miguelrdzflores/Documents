#include <stdlib.h>
#include <string.h>
#include "palmlibc.h" 
 
 
/* return 1 if unit must be executed on the driver proc  */
int if_ppalm_unitisondriver(char *cda_uname)
{
   return(0);
}
 
/* call the unit function on the driver  */
int if_ppalm_unitcall(char *cda_uname, int id_nb_proc)
{
   int il_err;
   MPI_Comm il_inter_comm;
   int il_argc;
   char **cl_argv;
   return(0);
}
 
void f2c_name(vf_ppalm_b0_sg_t0)(void *);
void f2c_name(c_vf_ppalm_b0_sg_t0)(void *ptr){
  f2c_name(vf_ppalm_b0_sg_t0)(ptr);
}



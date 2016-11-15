#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include "palmlibc.h" 
#include "palm_user_paramc.h" 
#include "lib_dvpvar.h" 
 
extern int PALM_Block_begin() ;
extern int PALM_Block_end();
extern int PALM_Start(int);
extern int PALM_Launch(char *, int (*)(),int, char**);
extern int f2c_name(if_ppalm_branches_instructions)(int *,int *);
extern int f2c_name(if_ppalm_ctrlstruc)(int *,int *,int *);




extern void f2c_name(condiciones)(); 
int if_condiciones_tr(int, char**);
int if_condiciones_tr(int argc, char **argv) {
   int il_err; 
 
   il_err = PALM_Init(argc, argv, "condiciones_1"); 
 
/* call unit fonctions */ 
   f2c_name(condiciones)(); 
 
 
   il_err += PALM_Finalize(); 
   return (0);
}




extern void f2c_name(solver)(); 
int if_solver_tr(int, char**);
int if_solver_tr(int argc, char **argv) {
   int il_err; 
 
   il_err = PALM_Init(argc, argv, "solver_1"); 
 
/* call unit fonctions */ 
   f2c_name(solver)(); 
 
 
   il_err += PALM_Finalize(); 
   return (0);
}
 
 
int C_MAIN_FOR_FORTRAN(int argc, char **argv, char **envp) { 
 
  /* declarations */
  int il_branch_BLOCK;
  int il_result_BLOCK;
  int il_func_BLOCK,il_inst_BLOCK;
  int il_err = 0,il_err2,il_err2exp;
 
  il_err = 0;
  il_err2exp = il_err;
  il_err = il_err2exp;
  il_err2 = PALM_Block_begin();
 
  il_branch_BLOCK = 0;
 
  /* Launch unit  */ 
  PALM_Launch("condiciones",if_condiciones_tr, argc, argv);
  {
   long long int T, il_begin, il_end, il_incr;

   il_inst_BLOCK = 1 ;
   f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
   /* recupere le debut de boucle */
   il_func_BLOCK = 1 ;
   f2c_name(if_ppalm_ctrlstruc)(&il_branch_BLOCK,&il_func_BLOCK,&il_result_BLOCK);
   il_begin = il_result_BLOCK;
 
   /* recupere la fin de boucle */
   il_func_BLOCK = 2;
   f2c_name(if_ppalm_ctrlstruc)(&il_branch_BLOCK,&il_func_BLOCK,&il_result_BLOCK);
   il_end = il_result_BLOCK;
 
   /* recupere l'increment de boucle */
   il_func_BLOCK = 3;
   f2c_name(if_ppalm_ctrlstruc)(&il_branch_BLOCK,&il_func_BLOCK,&il_result_BLOCK);
   il_incr = il_result_BLOCK;
 
   for (T = il_begin ; (il_end - T) * (il_begin -T) <= 0 ; T = T + il_incr) { 
 
/* PALM_PUT ==> f90 instruction 2 */
     il_inst_BLOCK = 2 ;
     f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
     /* Launch unit  */ 
     PALM_Launch("solver",if_solver_tr, argc, argv);
   il_inst_BLOCK = 3 ;
   f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
   }
  }
 
 
  il_err2 += PALM_Block_end();
  return (0);
}

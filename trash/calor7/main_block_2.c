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




extern void f2c_name(vecteur_print)(); 
int if_vecteur_print_tr(int, char**);
int if_vecteur_print_tr(int argc, char **argv) {
   int il_err; 
 
   il_err = PALM_Init(argc, argv, "vecteur_print_1"); 
 
/* call unit fonctions */ 
   f2c_name(vecteur_print)(); 
 
 
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
 
  il_branch_BLOCK = 1;
 
 
/* PALM_PUT ==> f90 instruction 4 */
  il_inst_BLOCK = 4 ;
  f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
 
/* PALM_PUT ==> f90 instruction 5 */
  il_inst_BLOCK = 5 ;
  f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
 
/* PALM_PUT ==> f90 instruction 6 */
  il_inst_BLOCK = 6 ;
  f2c_name(if_ppalm_branches_instructions)(&il_branch_BLOCK,&il_inst_BLOCK);
 
  /* Launch unit  */ 
  PALM_Launch("vecteur_print",if_vecteur_print_tr, argc, argv);
 
  il_err2 += PALM_Block_end();
  return (0);
}

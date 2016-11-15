#include <stdlib.h>
#include <string.h>
#include <stdio.h>
 
/* file created by prepalm_mp user miguel Tue Nov 15 16:39:03 CST 2016 */
 
/* return the .pil filename */
char *cf_prepalm_name()
{
    return("calor1d.pil");
}
 
/* return 1 if trace execution  is selected */
int if_ppalm_trace_execution()
{
    return 0;
}
 
/* return 1 if buffer_usage is selected */
int if_ppalm_trace_buffer()
{
    return 0;
}
 
/* return 1 if communication is selected */
int if_ppalm_trace_communication()
{
    return 0;
}
 
/* return 1 if pack/unpack is selected */
int if_ppalm_trace_pack()
{
    return 0;
}
/* return 1 if trace PCW is selected */
int if_ppalm_trace_pcw()
{
    return 0;
}
 
/* return 1 if redirect branches log file to /dev/null is selected */
int if_ppalm_redirect_log()
{
    return 0;
}
 
 
/* return the space of an object */
char *cf_ppalm_os(char *cla_uname, char *cla_oname)
{
   if (strcmp(cla_uname, "b1" ) == 0 )  {
      if (strcmp(cla_oname, "b1_put_1.b1" ) == 0 )  return("one_integer");
   }
   if (strcmp(cla_uname, "condiciones" ) == 0 )  {
      if (strcmp(cla_oname, "delta_t.condiciones" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "lambda.condiciones" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "t_min.condiciones" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "vecteur_u.condiciones" ) == 0 )  return("vect1d.condiciones");
      if (strcmp(cla_oname, "vecteur_x.condiciones" ) == 0 )  return("vect1d.condiciones");
   }
   if (strcmp(cla_uname, "refin" ) == 0 )  {
      if (strcmp(cla_oname, "refin_put_2.refin" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "refin_put_3.refin" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "refin_put_4.refin" ) == 0 )  return("one_integer");
   }
   if (strcmp(cla_uname, "solver2" ) == 0 )  {
      if (strcmp(cla_oname, "U.solver2" ) == 0 )  return("vect1d.solver2");
      if (strcmp(cla_oname, "X.solver2" ) == 0 )  return("vect1d.solver2");
      if (strcmp(cla_oname, "delta_t.solver2" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "lambda.solver2" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "time.solver2" ) == 0 )  return("one_double");
   }
   if (strcmp(cla_uname, "solver" ) == 0 )  {
      if (strcmp(cla_oname, "T.solver" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "U.solver" ) == 0 )  return("vect1d.solver");
      if (strcmp(cla_oname, "X.solver" ) == 0 )  return("vect1d.solver");
      if (strcmp(cla_oname, "delta_t.solver" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "lambda.solver" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "t_min.solver" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "time.solver" ) == 0 )  return("one_double");
   }
   if (strcmp(cla_uname, "vecteur_print" ) == 0 )  {
      if (strcmp(cla_oname, "Nmax.vecteur_print" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "Nmin.vecteur_print" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "U.vecteur_print" ) == 0 )  return("vect1d.solver");
      if (strcmp(cla_oname, "X.vecteur_print" ) == 0 )  return("vect1d.solver");
      if (strcmp(cla_oname, "delta_t.vecteur_print" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "lambda.vecteur_print" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "n_nest.vecteur_print" ) == 0 )  return("one_integer");
      if (strcmp(cla_oname, "time.vecteur_print" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "time_ref.vecteur_print" ) == 0 )  return("one_double");
      if (strcmp(cla_oname, "vecteur_u.vecteur_print" ) == 0 )  return("vect1d.vecteur_print");
      if (strcmp(cla_oname, "vecteur_x.vecteur_print" ) == 0 )  return("vect1d.vecteur_print");
   }
   return NULL;
}
 
/* retourne le mode mpi defini dans prepalm */
int if_ppalm_mpi_mode()
{
    return 2;
}
 
/* ================================== */
/* fonction de service pour mode MPI1 */
/* ================================== */
 
/* retourne le nombre d executable y compris le driver */
int if_ppalm_mpi1_nb_exec()
{
    return 4;
}
 
/* retourne le nombre de proc de chaque executables */
/* dans le même ordre que le nom des executable  */
/* y compris le driver, index 0  */
int cfa_ppalm_mpi1_exe_nb_proc(const int il_num)
{
 char *cl_nbproc;
  switch (il_num)
    {
     case 0:
         /* main_condiciones */
          cl_nbproc = getenv("NBPROC_main_condiciones");
          if (cl_nbproc == NULL) {
               return 1;
          } else {
               return atoi(cl_nbproc);
          } 
          break;
     case 1:
         /* main_solver */
          cl_nbproc = getenv("NBPROC_main_solver");
          if (cl_nbproc == NULL) {
               return 1;
          } else {
               return atoi(cl_nbproc);
          } 
          break;
     case 2:
         /* main_solver2 */
          cl_nbproc = getenv("NBPROC_main_solver2");
          if (cl_nbproc == NULL) {
               return 1;
          } else {
               return atoi(cl_nbproc);
          } 
          break;
     case 3:
         /* main_vecteur_print */
          cl_nbproc = getenv("NBPROC_main_vecteur_print");
          if (cl_nbproc == NULL) {
               return 1;
          } else {
               return atoi(cl_nbproc);
          } 
          break;
    }
}
 
/* retourne le premier proc de chaque executables */
/* par rapport à la commande mpiexec             */
/* y compris le driver, index 0  */
/* et pour le premier esclave memoire, index -1 */
int if_ppalm_firstproc_exe(const int id_num)
{
  int i, il_fp, il_num;
 
  il_num = id_num;
  if(id_num==-1) il_num= 4;
 
  il_fp=0;
  for (i=0; i<il_num;i++) il_fp += cfa_ppalm_mpi1_exe_nb_proc(i);
 
  return il_fp;
}
 
/* En fonction du rang dans MPI_COMM_WORLD */
/* retourne 1 ou 0 selon que l'unite appartient */
/* ou non à CWIPI */
int if_ppalm_mpi1_isoncwipi(int id_rank) 
{
   /* main_condiciones */
   if (id_rank <=  (if_ppalm_firstproc_exe(1)-1)) return 0;
   /* main_solver */
   if (id_rank <=  (if_ppalm_firstproc_exe(2)-1)) return 0;
   /* main_solver2 */
   if (id_rank <=  (if_ppalm_firstproc_exe(3)-1)) return 0;
   /* main_vecteur_print */
   if (id_rank <=  (if_ppalm_firstproc_exe(4)-1)) return 0;
   return 0;
}
 
/* retourne la liste du nom des executables */
char** cfa_ppalm_mpi1_exename()
{
   static char *cl_name[] = {"palm_main","main_condiciones","main_solver","main_solver2","main_vecteur_print"};
   return cl_name;
}
 
/* retourne la liste du nom des unite */
char** cfa_ppalm_mpi1_unitname()
{
   static char *cl_name[] = {"condiciones","solver","solver2","vecteur_print"};
   return cl_name;
}
 
/* retourne couleur en fonction du nom de l'unite */
int if_ppalm_mycolor(char *id_unit_name)
{
   char **cl_listexename;
   int il_mycolor = 0;
   int il_nb_exec, ib_i;
   
   cl_listexename = cfa_ppalm_mpi1_exename();
   il_nb_exec = if_ppalm_mpi1_nb_exec();
   for(ib_i=0; ib_i<il_nb_exec; ib_i++)
   {
       if(strcmp(id_unit_name,cl_listexename[ib_i])==0)
       il_mycolor=ib_i;
   }
   return il_mycolor;
}
/* retourne le numero d executable en fonction du nom de l entite */
int if_ppalm_exenum_for_entname(char *cd_entname)
{
 
   /* BUFFER ---> 0 ---> 0 */
   if (strcmp("BUFFER",cd_entname) == 0) return 0;
 
   /* b1 ---> 0 ---> 0 */
   if (strcmp("b1",cd_entname) == 0) return 0;
 
   /* refin ---> 0 ---> 0 */
   if (strcmp("refin",cd_entname) == 0) return 0;
 
   /* condiciones ---> 0 ---> 0 */
   if (strcmp("condiciones",cd_entname) == 0) return 0;
 
   /* solver ---> 1 ---> 1 */
   if (strcmp("solver",cd_entname) == 0) return 1;
 
   /* solver2 ---> 2 ---> 2 */
   if (strcmp("solver2",cd_entname) == 0) return 2;
 
   /* vecteur_print ---> 3 ---> 3 */
   if (strcmp("vecteur_print",cd_entname) == 0) return 3;
 
   printf("Error in if_ppalm_exenum_for_entname\n");
   return 0;
}
/* retourne le numero de branche en fonction du nom de l entite */
int if_ppalm_branch_for_entname(char *cd_entname)
{
 
   /* condiciones ---> 0 */
   if (strcmp("main_condiciones",cd_entname) == 0) return 0;
   /* solver ---> 0 */
   if (strcmp("main_solver",cd_entname) == 0) return 0;
   /* solver2 ---> 1 */
   if (strcmp("main_solver2",cd_entname) == 0) return 1;
   /* vecteur_print ---> 1 */
   if (strcmp("main_vecteur_print",cd_entname) == 0) return 1;
 
   printf("Error in if_ppalm_branch_for_entname\n");
   return -1;
}
/* retourne le numero d executable en fonction du numero */
/* de proc dans MPI_COMM_WORLD */
int if_ppalm_mpi1_exe_num(const int id_rank)
{
  int i, il_exec;
  il_exec = -1;
  for (i=0; i<if_ppalm_mpi1_nb_exec(); i++) {
     if (id_rank >=  if_ppalm_firstproc_exe(i)) {
       il_exec++;
     }
  }
  return il_exec;
}

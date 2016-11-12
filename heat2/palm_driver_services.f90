integer function if_ppalm_branches_instructions(id_branch,id_linesw)
!
!**** if_ppalm_branches_instructions : branches trigger
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
!
   implicit none
!
   integer :: id_branch, id_linesw
!
   integer :: if_ppalm_b0_ctrlstruc
!
   select case (id_branch) 
     case (0)
          if_ppalm_branches_instructions = if_ppalm_b0_ctrlstruc(id_linesw)
          return
     case default
          if_ppalm_branches_instructions = 1
          return
   end select
end function if_ppalm_branches_instructions




module m_ppalm_driver_b0
  use palmlib
  use palm_user_param
  
!
!**** module m_ppalm_driver_b0 : private variable for branch barra1
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
   integer :: ig_bdon_branch_0 ! for no warning if the module is empty

CONTAINS

SUBROUTINE palm_dump_branch_var()
    print *,'>>>======================= Branch 0 DUMP ================='

    print *,'>>>======================= END      DUMP ================='
END SUBROUTINE palm_dump_branch_var

end module m_ppalm_driver_b0



integer function if_ppalm_b0_ctrlstruc(id_linesw)
!
!**** if_ppalm_b0_ctrlstruc : trigger instructions for F90 region
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
 
   use palmlib
   use palm_user_param
   use m_ppalm_driver_b0
 
   implicit none
   include 'mpif.h'
!
   integer :: id_linesw
!
   integer :: il_ppalm_err, il_ppalm_err2, il_ppalm_time, il_ppalm_tag, il_ppalm_rank
   CHARACTER(LEN=PL_LNAME)       :: cl_ppalm_space, cl_ppalm_name
!
!  select the intructions to execute */
!
   select case (id_linesw) 

     case default
        if_ppalm_b0_ctrlstruc = 1
        return

   end select

end function if_ppalm_b0_ctrlstruc




integer function if_ppalm_ctrlstruc(id_branch,id_func,id_value)
!  branch trigger 
!
   implicit none
!
   integer :: id_branch, id_func,id_value
!
   integer :: if_ppalm_0_br_serv
!
   select case (id_branch) 
     case (0)
          if_ppalm_ctrlstruc = if_ppalm_0_br_serv(id_func,id_value)
          return
     case default
          if_ppalm_ctrlstruc = 1
          return
   end select
end function if_ppalm_ctrlstruc




integer function if_ppalm_0_br_serv(id_func,id_value)
!
!**** if_ppalm_0_br_serv : 
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
 
   use m_ppalm_driver_b0
   use palm_user_param
 
   implicit none
!
   integer :: id_func,id_value
   logical :: ll_test
!
!  select the code to execute */
!
   if_ppalm_0_br_serv = 0
!
   select case (id_func) 
     case default
        if_ppalm_0_br_serv = 1
        return
   end select
end function if_ppalm_0_br_serv




integer function if_ppalm_exchange_module(id_branch,id_way,id_bloc,id_proc)
!
!**** if_palm_exchange_module : branches trigger for send/recv module
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
!
   implicit none
!
   integer :: id_way,id_branch,id_bloc,id_proc
!                     id_way = 1 (IP_SEND) send module whith current values of variables
!                     id_way = 2 (IP_RECV) recv module and setup variables
!
   integer :: if_ppalm_b0_exchange_module
!
   if (id_way.ne.1.and.id_way.ne.2) then 
      if_ppalm_exchange_module = 1
      return
   endif
 
   select case (id_branch) 
     case (0)
          if_ppalm_exchange_module = if_ppalm_b0_exchange_module(id_way,id_bloc,id_proc)
          return
     case default
          if_ppalm_exchange_module = 1
          return
   end select
end function if_ppalm_exchange_module




integer function if_ppalm_b0_exchange_module(id_way,id_bloc,id_proc)
!
!**** if_ppalm_b0_ctrlstruc : Send function for block/driver exchanges
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
 
   use m_ppalm_driver_b0
 
   implicit none
   integer, parameter :: IP_PORT_ENT = 1
   integer :: id_way,id_bloc,id_proc
!                     id_way = 1 send module whith current values of variables
!                     id_way = 2 recv module and setup variables
   integer :: il_err
 
!
   if (id_way.eq.1) then

   endif
 
   if (id_way.eq.2) then

   endif
   if_ppalm_b0_exchange_module = 0
end function if_ppalm_b0_exchange_module




integer function if_ppalm_nbproc_unit(id_branch,id_unit,id_flag,id_value)
!  branch trigger for unit's nbproc 
!
   implicit none
!
   integer :: id_branch, id_flag, id_unit,id_value
!
   integer :: if_ppalm_b0_nbproc_unit
!
 
 
   select case (id_branch) 
     case (0)
          if_ppalm_nbproc_unit = if_ppalm_b0_nbproc_unit(id_unit,id_flag,id_value)
          return
     case default
          if_ppalm_nbproc_unit = 1
          return
   end select
end function if_ppalm_nbproc_unit




integer function if_ppalm_b0_nbproc_unit(id_unit,id_flag,id_value)
!
!**** if_ppalm_b0_nbproc_unit : 
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
 
   use m_ppalm_driver_b0
   use palm_user_param
 
   implicit none
!
   integer :: id_unit,id_flag,id_value,il_maxi_proooc
   character(len=80) :: cl_nbproc
!
!
!  select the code to execute */
!
   if_ppalm_b0_nbproc_unit = 0
!
   select case (id_unit) 
          case (1)
!              main_difusion
               call getenv('NBPROC_main_difusion',cl_nbproc)
               if (cl_nbproc(1:3) .eq. '   ') then 
                   id_value = 1
!                   print *, '====> nb_proc affecte par defaul par prepalm a : ',id_value
               else
                    read (cl_nbproc,*) id_value
!                    print *, '====> nb_proc Lu dans la variable env :',id_value
               endif
               return
          case default
               if_ppalm_b0_nbproc_unit = 1
               return
   end select
end function if_ppalm_b0_nbproc_unit


!***************************************************************
!
!
!          fonctions de service pour les fichiers 
!
!***************************************************************

integer function if_ppalm_puttofile(id_tube)
!  cette fonction retourne 0 ou 1 selon que le tube abouti ou non a un fichier
 
   implicit none
 
   integer :: id_tube, il_retour
 
   il_retour =0
 
   if_ppalm_puttofile = il_retour
end function if_ppalm_puttofile



subroutine ppalm_printtofile(id_index, id_tube, id_time, id_tag, id_rank, ida_obj,id_size, id_putdlrk)
!  trigger sur le numero de tube 
  integer :: id_tube, id_size, ida_obj, id_time, id_tag, id_rank, id_putdlrk
end subroutine ppalm_printtofile



integer function  if_ppalm_flnmw(id_tube,cla_formfile,id_time,id_tag,id_rank)
!  trigger sur le numero de tube 
   integer :: id_tube,  id_time, id_tag, id_rank
   character(LEN=256) :: cla_formfile
 
  if_ppalm_flnmw = -1
end function if_ppalm_flnmw


integer function if_ppalm_getfromfile(id_tube)
!  cette fonction retourne 0 ou 1 selon que le tube demare ou non d'un fichier
 
   implicit none
 
   integer :: id_tube, il_retour
 
   il_retour =0
 
   if_ppalm_getfromfile = il_retour
end function if_ppalm_getfromfile



subroutine ppalm_getfromfile(id_index, id_tube, id_time, id_tag, id_rank, ida_obj,id_size, id_putdlrk)
!  trigger sur le numero de tube 
  integer :: id_tube, id_size, ida_obj, id_time, id_tag, id_rank, id_putdlrk
end subroutine ppalm_getfromfile



integer function  if_ppalm_flnmr(id_tube,cla_formfile,id_time,id_tag,id_rank)
!  trigger sur le numero de tube 
   integer :: id_tube,  id_time, id_tag, id_rank
   character(LEN=256) :: cla_formfile
 
  if_ppalm_flnmr = -1
end function if_ppalm_flnmr




SUBROUTINE ppalm_descriptor_trigger(cd_function_name, id_len, id_action,  &
   id_nproc, id_arank, ida_shape, id_usrinfo_sz, ida_usrinfo, id_size, &
   ida_descr)
!
!     file automaticaly generated by PREPALM, don't edit this file
!*----------------------------------------------------------------
!
!** 1. DECLARATION
!
!** 1.1 Modules
!
  USE palmlib
!  
  IMPLICIT NONE
!
!
!** 1.2 Dummy variables 
!

  CHARACTER(LEN=PL_LNAME), INTENT(IN)      :: cd_function_name
  INTEGER, INTENT(IN)                      :: id_nproc, id_arank, id_action, &
                                              id_len, id_usrinfo_sz
  INTEGER, DIMENSION(id_arank), INTENT(IN) :: ida_shape
  INTEGER, INTENT(INOUT)                   :: id_size
  INTEGER, DIMENSION(id_size)              :: ida_descr !out
  INTEGER, DIMENSION(id_usrinfo_sz), INTENT(IN)        :: ida_usrinfo  
!
!** 1.3 Local variables 
!
  CHARACTER(LEN=PL_LNAME)       :: cl_function_name
  INTEGER                       :: il_err
!
!*----------------------------------------------------------------
!
  cl_function_name = ''
  cl_function_name(1:id_len) = cd_function_name(1:id_len)

  SELECT CASE(cl_function_name)
  
  CASE DEFAULT
         WRITE(*,*) 'Error: Function Not found!'
 
  END SELECT
 
END SUBROUTINE ppalm_descriptor_trigger
 
 
 

SUBROUTINE ppalm_so_trigger(cd_function_name, id_len, id_action, &
   id_orank, ida_shape, id_usrinfo_sz, ida_usrinfo, id_size, ida_descr)
!
!****  ppalm_so_trigger
!
!     Purpose:
!     --------
!       User subroutine for calling a sub-object descriptor function.
!       These functions allow to describe the sub-object of an object on
!       a unit.  
!       It must have in input : 
!         id_action        : contains PL_GIVE_SIZE if the user function must
!                            return the size of the sub-object descriptor vector, 
!                            PL_GIVE_DESCR if the user function must return the
!                            filled sub-object descriptor vector
!         id_orank         : rank of the object
!         ida_shape        : shape of the object
!         id_len           : length of the function name
!         ida_usrinfo      : user informations usefull for computing the 
!                            sub-object descriptor can be passed through this 
!                            vector for dynamic sub-object descriptions 
!         id_usrinfo_sz : size of ida_usrinfo
!       in output :
!         id_size : the size of the sub-object descriptor vector ida_descr
!         ida_descr : the sub-object descriptor vector 
!
!***  Interface:
!     ----------
!         CALL ppalm_so_trigger(cd_function_name, id_len, id_action, &
!   id_orank, ida_shape, id_usrinfo_sz, ida_usrinfo, id_size, ida_descr)
!
!      Inputs:
!      -------
!         cd_function_name : name of the function to call
!         id_action        : contains PL_GIVE_SIZE if the user function must
!                            return the size of the sub-object descriptor vector, 
!                            PL_GIVE_DESCR if the user function must return the
!                            filled sub-object descriptor vector
!         id_orank         : rank of the object
!         ida_shape        : shape of the object
!         ida_usrinfo      : user informations usefull for computing the 
!                            sub-object descriptor can be passed through this 
!                            vector for dynamic sub-object descriptions 
!         id_usrinfo_sz : size of ida_usrinfo
!
!      Outputs:
!      --------
!         id_size : the size of the sub-object descriptor vector ida_descr
!         ida_descr : the sub-object descriptor vector 
!
!

!     Externals:
!     ----------
!       Modules:
!       --------
!          palmlib, pl_def_err
!
!     History:
!     -------
!     file automaticaly generated by PREPALM, don't edit this file
!*----------------------------------------------------------------
!
!** 1. DECLARATION
!
!** 1.1 Modules
!
  USE palmlib
!  
  IMPLICIT NONE
!
!
!** 1.2 Dummy variables 
!

  CHARACTER(LEN=PL_LNAME), INTENT(IN)      :: cd_function_name
  INTEGER, INTENT(IN)                      :: id_orank, id_action, &
                                              id_len, id_usrinfo_sz
  INTEGER, DIMENSION(id_orank), INTENT(IN) :: ida_shape
  INTEGER, INTENT(INOUT)                   :: id_size
  INTEGER, DIMENSION(id_size)              :: ida_descr !out
  INTEGER, DIMENSION(id_usrinfo_sz), INTENT(IN)        :: ida_usrinfo  
!
!** 1.3 Local variables 
!
  CHARACTER(LEN=PL_LNAME)       :: cl_function_name
  INTEGER                       :: il_err
!
!*----------------------------------------------------------------
!
  cl_function_name = ''
  cl_function_name(1:id_len) = cd_function_name(1:id_len)

  SELECT CASE(cl_function_name)

 
  CASE DEFAULT
         WRITE(*,*) 'Error: Function Not found!'
 
  END SELECT
 
END SUBROUTINE ppalm_so_trigger 

!***************************************************************
!          time & tag functions
!***************************************************************
integer function if_ppalm_timetag_search(id_numfunc,id_z_srctgtflag,id_time,id_tag,id_z_nb,ida_z_list,id_z_list_size)
   implicit none
 
   integer, intent(in)    :: id_numfunc,id_z_srctgtflag,id_time,id_tag,id_z_list_size
   integer, intent(inout) :: id_z_nb,ida_z_list(*)
 
 
   if_ppalm_timetag_search = -1
   id_z_nb = 0
 
   select case (id_numfunc) 
   end select
end function if_ppalm_timetag_search


integer function if_ppalm_timetag_nb(id_numfunc)
   implicit none
 
   integer, intent(in)    :: id_numfunc
 
 
   if_ppalm_timetag_nb = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_timetag_nb


integer function if_ppalm_time_nb(id_numfunc)
   implicit none
 
   integer, intent(in)    :: id_numfunc
 
 
   if_ppalm_time_nb = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_time_nb


integer function if_ppalm_tag_nb(id_numfunc)
   implicit none
 
   integer, intent(in)    :: id_numfunc
 
 
   if_ppalm_tag_nb = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_tag_nb


integer function if_ppalm_give_timetag(id_numfunc,id_z_srctgtflag,id_lcommid,id_time,id_tag)
   implicit none
 
   integer, intent(in)    :: id_numfunc,id_z_srctgtflag,id_lcommid 
   integer                :: id_time,id_tag !out
 
 
   if_ppalm_give_timetag = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_give_timetag


integer function if_ppalm_time_nbor(id_numfunc,id_time_in,id_nbor_inf_found,id_nbor_inf,id_nbor_sup_found,id_nbor_sup)
!  
!  Cette fonction permet de retourner les plus proches voisins pour le time dans un tube donne 
!  en entree 
!      id_numfunc  : identifiant de la fonction a appeler (donne dans le .pil) 
!      id_time_in  : time duquel on veut les plus proches voisins
!  en sortie 
!      id_nbor_inf_found : 0 ou 1 si un plus proche voisin inferieur a id_time_in est trouve
!      id_nbor_sup_found : 0 ou 1 si un plus proche voisin superieur a id_time_in est trouve
!      id_nbor_inf : plus proche voisin inferieur a id_time_in
!      id_nbor_sup : plus proche voisin superieur a id_time_in
!  
!  la valeur de retour de la fonction est -1 en cas de probleme et id_nbor_inf_found + 2*id_nbor_sup_found
!  sinon 
!  
   implicit none
!  
   integer, intent(in)    :: id_numfunc, id_time_in
   integer                :: id_nbor_inf,id_nbor_sup ! out
   integer                :: id_nbor_inf_found,id_nbor_sup_found ! out
 
 
   if_ppalm_time_nbor = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_time_nbor


!***************************************************************
!          END time & tag functions
!***************************************************************
integer function if_ppalm_in_localisation(cd_object, id_len, id_proc)
! =============================================================
! fonction de service pour les localisations des objets
! cd_object : nom de l'objet suffixe par l'unite 
! id_len    : longueur de la chaine cd_object pour compatibilité C  
! id_proc   : numero du proc dans la liste des proc de l'unite 
! 
! retourne 0 si le proc n''est pas dans la localisation
!          1 si le proc est dans la localisation
! 
! =============================================================
   use gen_palmdef_f
   use palm_user_param
!  
   implicit none
!  
   character(len=PL_LNAME), intent(in) :: cd_object
   integer, intent(in) :: id_len, id_proc
   integer :: iloc_ixxfg
     if_ppalm_in_localisation = 0
     iloc_ixxfg = 0
!    cas par defaut pour les  SINGLE_ON_FIRST_PROC
     if(id_proc.eq.0) if_ppalm_in_localisation = 1
     return
end function if_ppalm_in_localisation


!***************************************************************
!          localisation functions
!***************************************************************
integer function if_ppalm_assoc_nb(id_numfunc,id_nbprocsrcinpalm,id_nbproctgtinpalm)
!trigger qui retourne le nombre d'association
   implicit none
 
   integer, intent(in)    :: id_numfunc
   integer, intent(in)    :: id_nbprocsrcinpalm
   integer, intent(in)    :: id_nbproctgtinpalm
 
 
   if_ppalm_assoc_nb = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_assoc_nb


integer function if_ppalm_assoc_list(id_numfunc,id_numproc,id_side,id_nbprocsrcinpalm,&
                               id_nbproctgtinpalm,ida_assoclist,id_assoclist_size,id_assoc_nb)
!trigger qui retourne les numeros des associations
   implicit none
 
   integer, intent(in)    :: id_numfunc,id_numproc,id_side,id_assoclist_size
   integer, intent(in)    :: id_nbprocsrcinpalm
   integer, intent(in)    :: id_nbproctgtinpalm
   integer                :: ida_assoclist(id_assoclist_size) !out 
   integer                :: id_assoc_nb !out
   if_ppalm_assoc_list= -1
   select case (id_numfunc) 
   end select
end function if_ppalm_assoc_list
integer function if_ppalm_assoc_loc(id_numfunc,id_numassoc,id_side,id_nbprocsrcinpalm,&
                                   id_nbproctgtinpalm,ida_listproc,id_listproc_size,id_proc_nb)
!trigger pour les fonctions qui retournent les proc des  d'association 
   implicit none
 
   integer, intent(in)    :: id_numfunc,id_numassoc,id_side,id_listproc_size
   integer, intent(in)    :: id_nbprocsrcinpalm
   integer, intent(in)    :: id_nbproctgtinpalm
   integer                :: ida_listproc(id_listproc_size) !out
   integer                :: id_proc_nb !out
   if_ppalm_assoc_loc= -1
   select case (id_numfunc) 
   end select
end function if_ppalm_assoc_loc


!***************************************************************
!          END localisation functions
!***************************************************************
!***************************************************************
!         STEP time & tag functions
!***************************************************************
integer function if_ppalm_steptimetag_idx(id_numfunc,id_time,id_tag)
   implicit none
 
   integer, intent(in)    :: id_numfunc,id_time,id_tag
   integer :: i,j,nx
 
 
   if_ppalm_steptimetag_idx = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_steptimetag_idx


integer function if_ppalm_steptimetag_nb(id_numfunc)
   implicit none
 
   integer, intent(in)    :: id_numfunc
 
 
   if_ppalm_steptimetag_nb = -1
 
   select case (id_numfunc) 
   end select
end function if_ppalm_steptimetag_nb


!***************************************************************
!          END time & tag STEP functions
!***************************************************************
integer function if_ppalm_arg_script(id_branch,id_func,cd_argc,id_len)
!  branch trigger 
!
   implicit none
!
   integer :: id_branch, id_func, id_len
   character(LEN=256) :: cd_argc
!
   integer :: if_ppalm_arg_b0_script
!
   select case (id_branch) 
     case (0)
          if_ppalm_arg_script = if_ppalm_arg_b0_script(id_func,cd_argc,id_len)
          return
     case default
          if_ppalm_arg_script = 1
          return
   end select
end function if_ppalm_arg_script




integer function if_ppalm_arg_b0_script(id_func,cd_argc,id_len)
!
!**** if_ppalm_arg_b0_script : 
!
!     Purpose:
!     --------
!
!     File generated by PrePALM user: miguel 
!                               date: Wed Jul 20 13:11:25 CDT 2016 
!     Don't edit this file!
!
!*--------------------------------------------------------------------------
!
 
   use m_ppalm_driver_b0
 
   implicit none
!
   integer :: id_func, id_len
   character(LEN=256) :: cd_argc
   logical :: ll_test
!
   character(LEN=300) :: cl_form
!  select the code to execute */
!
   if_ppalm_arg_b0_script = 0
   cd_argc = ''
!
   select case (id_func) 
     case default
        if_ppalm_arg_b0_script = 1
        return
   end select
end function if_ppalm_arg_b0_script




integer function if_ppalm_branches_setget(id_branch,cd_name,id_len,id_val)
!
   use palmlib
!
   implicit none
!
   integer :: id_branch, id_val,id_len
   character(LEN=PL_LNAME) :: cd_name
   character(LEN=PL_LNAME) :: cl_name
!
   integer :: if_ppalm_b0_setget
!
   cl_name = cd_name(1:id_len)
   select case (id_branch) 
     case (0)
          if_ppalm_branches_setget = if_ppalm_b0_setget(cl_name,id_val)
          return
     case default
          if_ppalm_branches_setget = 0
          return
   end select
end function if_ppalm_branches_setget




integer function if_ppalm_b0_setget(cd_name,id_val)
 
   use palmlib
 
   implicit none
!
   integer :: id_val
   character(LEN=PL_LNAME) :: cd_name
!
!
!  select the intructions to execute */
!
   select case (cd_name) 

     case default
        if_ppalm_b0_setget = 0
        return

   end select

end function if_ppalm_b0_setget








subroutine palm_time_conv_init()
 
   use gen_palmdef_f
 
   implicit none
 
   integer :: il_time_step,il_year,il_month,il_day,il_hour
   integer :: il_min,il_sec,il_firsttime,il_calendar
 
   il_time_step = PL_TIME_DAY
   il_year      = 1950
   il_month     = 1
   il_day       = 1
   il_hour      = 0
   il_min       = 0
   il_sec       = 0
   il_firsttime = 0
   il_calendar  = PL_STANDARD_CALENDAR
 
   call palm_time_conv_set(il_time_step,il_year,il_month,il_day,il_hour,il_min,il_sec,il_firsttime,il_calendar)
 
end subroutine palm_time_conv_init




 
SUBROUTINE pl_ipr_updatevents
  IMPLICIT NONE
  RETURN
END SUBROUTINE pl_ipr_updatevents
!===================================================
! algebra modules ands subroutines                   
!===================================================
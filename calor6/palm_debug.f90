!    This file is part of O-PALM.
!
!    O-PALM is free software: you can redistribute it and/or modify
!    it under the terms of the GNU Lesser General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    O-PALM is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU Lesser General Public License for more details.
!
!    You should have received a copy of the GNU Lesser General Public License
!    along with O-PALM.  If not, see <http://www.gnu.org/licenses/>.
!
!    Copyright 1998-2011 (c) CERFACS 
!
! O-PALM tag 4.0.0

SUBROUTINE pl_debug(id_space_len,cd_space,id_name_len, cd_name, id_time, id_tag,id_nbelts,id_obj_sz,ida_obj)
!
!**** TITLE - pl_debug : User defined debug procedures
!
!     Purpose:
!     --------
!     To apply user defined debug procedures to objects handled by PALM
!
!     Interface:
!     ----------
!     There is no direct call in the user's programs. This routine is 
!     activated by the PrePALM interface through the DEBUG parameter of
!     communications. If PL_DEBUG_ON_SEND is selected, the debug procedure
!     is applied during the execution of PALM_Put. If PL_DEBUG_ON_RECV 
!     is selected, the debug procedure is applied during the execution of 
!     PALM_Get. If PL_DEBUG_ON_BOTH is selected, the debug procedure is 
!     applied both during the execution on PALM_Put and the execution
!     of PALM_Get.
!     The user has to define his own debug procedures in the internal SELECT
!     CASE.
!     The variable id_nbelts contains the number of elements of the 
!     object to debug.
!
!***  Method:
!     -------
!     Select an appropriate debug procedure following the space name.
!     "Cast" the PALM object into the mould of the type of the concerned
!     space.
!     Apply the debug procedure.
!     Return a user defined error code.
!
!     Externals:
!     ----------
!     None
!
!     Files:
!     ------
!     None
!
!     References:
!     -----------
!     The PALM Software User's Guide
!
!     History:
!     --------
!      Version    Programmer      Date         Description
!      -------    ----------      ----         -----------
!       1.0       Andrea        1999/12/20     Complete reshape
!       2.0       N.B.          2004/03/22     Complete reshape (RESEARCH TO MP)
!*--------------------------------------------------------------------------
!
!**   0. DECLARATIONS  
!        ------------
!
!**   0.1 Include files and modules
!
  USE palmlib     !*I The PALM interface
!
!**   0.2 Local variables 
!
  IMPLICIT NONE
!
!*V Palm Related Variables. DO NOT CHANGE IT.
!
  INTEGER, INTENT(in)	                  :: id_space_len,id_name_len
  CHARACTER(LEN=id_space_len), INTENT(in)  :: cd_space  
  CHARACTER(LEN=id_name_len), INTENT(in)   :: cd_name
  INTEGER, INTENT(in)            :: id_time
  INTEGER, INTENT(in)            :: id_tag
  INTEGER, INTENT(in)            :: id_nbelts ! number of element of the object
  INTEGER, INTENT(in)            :: id_obj_sz ! the size of the object (in number of integer)
  INTEGER, DIMENSION(id_obj_sz), INTENT(in)  :: ida_obj
!
! test reproducibility between two runs 
! to operate, do not forget to use PL_DEBUG_ON_SEND for all communications in prepalm 
! 
! IP_TRACE_COMM = 0 nothing is done
!               = 1 writing of Reference
!               = 2 reading and comparison

  INTEGER, PARAMETER :: IP_TRACE_COMM = 0
  INTEGER, ALLOCATABLE :: ida_comp(:)
  INTEGER :: file_already_open = 0
  COMMON /trace_comm/ file_already_open 
  INTEGER :: ib_do, il_err, il_rank
  CHARACTER(LEN=PL_LNAME) :: cl_entname
  CHARACTER(LEN=4) :: cl_proc
  CHARACTER(LEN=256) :: cl_check_file
  LOGICAL :: ll_exist
  
  IF(IP_TRACE_COMM.NE.0) THEN
     CALL PALM_Get_myname(cl_entname,il_err)
     CALL MPI_Comm_rank(PL_COMM_EXEC,il_rank,il_err)
     WRITE(cl_proc,'(I4.4)')il_rank
     cl_check_file = TRIM(cl_entname)//cl_proc//'.debug' 

     IF (file_already_open .eq. 0) THEN
        file_already_open = 1 
        IF(IP_TRACE_COMM .EQ. 1) THEN
           OPEN(1007,FILE=cl_check_file,form='unformatted')
        ELSE
           INQUIRE(FILE=cl_check_file, exist = ll_exist)
           IF (ll_exist) THEN
              
           ELSE
              WRITE(PL_OUT,*) 'ERROR in palm_debug.f90, file '//cl_check_file//' does not exist'
              WRITE(PL_OUT,*) 'You must do a first run with IP_TRACE_COMM = 1'
              CALL PALM_Abort(il_err)
           ENDIF
           OPEN(1007,file=cl_check_file,form='unformatted',status='old')
        ENDIF
     ENDIF
     
     IF(IP_TRACE_COMM .EQ. 1) THEN
        WRITE(1007)ida_obj
     ELSE
        ALLOCATE(ida_comp(id_obj_sz))
        READ(1007)ida_comp
        DO ib_do = 1, id_obj_sz
           IF(ida_comp(ib_do) .NE. ida_obj(ib_do)) THEN
              PRINT *, '===================> Check object ERROR'
              PRINT *, '=====> Object       :',cd_name
              PRINT *, '=====> Object size  :',id_obj_sz
              PRINT *, '=====> Object index :',ib_do
              PRINT *, '=====> Space        :',cd_space
              PRINT *, '=====> Time         :',id_time
              PRINT *, '=====> Tag          :',id_tag
              PRINT *, '==================> call PALM_Abort'
              WRITE(PL_OUT,*) '===================> Check object ERROR'
              WRITE(PL_OUT,*) '=====> Object       :',cd_name
              WRITE(PL_OUT,*) '=====> Object size  :',id_obj_sz
              WRITE(PL_OUT,*) '=====> Object index :',ib_do
              WRITE(PL_OUT,*) '=====> Space        :',cd_space
              WRITE(PL_OUT,*) '=====> Time         :',id_time
              WRITE(PL_OUT,*) '=====> Tag          :',id_tag
              WRITE(PL_OUT,*) '==================> call PALM_Abort'
              CALL PALM_Abort(il_err)
           ENDIF
        ENDDO
        WRITE(PL_OUT,*)'DEBUG: Object ', cd_name, ', contains checked, OK' 
        DEALLOCATE(ida_comp)
     ENDIF
  ENDIF

!
!*V Local user defined variables
!
!  FOR EXAMPLE
!
!  REAL(KIND=8), DIMENSION(id_nbelts) :: dla_double
!
!  TYPE tder
!    SEQUENCE
!    INTEGER :: il_first
!    INTEGER :: il_second
!    REAL, DIMENSION(12) :: rla_real
!  END TYPE tder
!  TYPE (tder), DIMENSION(id_nbelts) :: sla_type
!
!  INTEGER :: ib
!  INTEGER :: il_op
!  INTEGER :: il_err
!
!*--------------------------------------------------------------------------
!
!**   1. DEBUG PROCEDURES
!        ----------------
!
!**   1.1 Entering the selection : DO NOT CHANGE THIS LINES 
!
  WRITE(PL_OUT,*) 'DEBUG: Applying debug to object ',cd_name 
  WRITE(PL_OUT,*) '       at time ', id_time, 'for space ',cd_space
  SELECT CASE(cd_space)
!
!**   1.2 User defined cases
!
!
! FOR EXAMPLE
!
!
!!*C Remember than PALM identifies spaces by a string composed by
!!   the space name suffixed by the name of the unit defining the
!!   the space. For instance, if the space "dspace" is defined in
!!   the identity card of the unit "the_unit" the corresponding
!!   internal PALM identifier is "dspace.the_unit"
!
!
!  CASE('dspace.the_unit')
!
!!
!!*C To print some statistics about an object, the simplest way is to use the
!!   PALM primitive PALM_Dump as follows
!
!!     il_op must be the sum of the different desired operation (PL_DUMP_ALL,
!!     PL_DUMP_MIN, PL_DUMP_MAX, PL_DUMP_SUM)  
!      il_op = PL_DUMP_MIN+PL_DUMP_MAX+PL_DUMP_SUM
!      CALL PALM_Dump(il_op, cd_space, cd_name, id_time, id_tag, ida_obj, &
!                     il_err)
!      IF (il_err.ne.IP_NOERR) THEN
!        WRITE(PL_OUT,*) 'Error in PALM_Dump'
!        CALL PALM_Abort(il_err) 
!      END IF
!
!
!!*C If the user wants to compute his/her own statistics, he/she must cast 
!!   ida_obj (the representation of the object values in an integer array) 
!!   into the write type of the object. Thus, the following line has to start 
!!   the case block.
!!   The format is user_variable = TRANSFER(ida_obj, user_variable)
!!   Where user_variable declaration corresponds to the type 
!!   associated to the space
!
!!   For a double precision vector:
!      dla_double = TRANSFER(ida_obj, dla_double)
!
!!   In the case of multidimensional arrays this line should
!!   take the form
!!
!!      dla_double = RESHAPE(TRANSFER(ida_obj, dla_double), &
!                           SHAPE(dla_double))
!
!      WRITE(PL_OUT,*) 'Min Value = ', MINVAL(dla_double)
!      WRITE(PL_OUT,*) 'Max Value = ', MAXVAL(dla_double)
!      IF (MAXVAL(dla_double) .gt. 40.d0) THEN
!         WRITE(PL_OUT,*) 'ERROR : Value of ',cd_name,' is too high'
!         id_err = 999
!      END IF
!      DO ib = 1,id_nbelts
!	WRITE(PL_OUT,*) dla_double(ib)
!      END DO
!
!!   An example of derived type object
!!
!      sla_type = TRANSFER(ida_obj, sla_type)
!      DO ib = 1,id_nbelts
!	 WRITE(PL_OUT,*) sla_type(ib)%il_first
!	 WRITE(PL_OUT,*) sla_type(ib)%il_second
!        WRITE(PL_OUT,*) 'Min Value = ', MINVAL(sla_type(ib)%rla_real)
!        WRITE(PL_OUT,*) 'Max Value = ', MAXVAL(sla_type(ib)%rla_real)
!      END DO
!      CALL PALM_Dump(PL_DUMP_ALL+PL_DUMP_MIN+PL_DUMP_MAX+PL_DUMP_SUM, &
!                     'tspace',cd_name,PL_NO_TIME,PL_NO_TAG,ida_obj,il_err)
!      IF (il_err.ne.IP_NOERR) THEN
!        WRITE(PL_OUT,*) 'Error in PALM_Dump'
!        CALL PALM_Abort(il_err) 
!      END IF
!
!
!!*C Uncomment these lines to treat each object that have a pre-defined space
!
!  CASE('one_integer','one_real','one_double', &
!       'one_complex','one_logical',&
!       'one_string','one_character')
!
!      CALL PALM_Dump(PL_DUMP_ALL,cd_space,cd_name, & 
!	 PL_NO_TIME,PL_NO_TAG,ida_obj,il_err)
!
!**   1.3 End of the selection. DO NOT CHANGE THESE LINES.
!
  CASE default
      WRITE(PL_OUT,*) 'DEBUG: No debug action associated '
      WRITE(PL_OUT,*) '       to space ',cd_space
  END SELECT
!	  
!*--------------------------------------------------------------------------
!
END SUBROUTINE pl_debug
!	  
!*==========================================================================



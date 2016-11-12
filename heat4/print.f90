!
!
!
!
!
!
!
!M.I. Miguel Angel Rodriguez Flores

!PALM_UNIT -name print\
!          -functions {F90 print}\
!          -object_files {print.o}\
!          -comment {imprime en pantalla resultados}
!
! 
!PALM_SPACE -name mat1d\
!           -shape (IP_SIZE) \
!           -element_size PL_DOUBLE_PRECISION\
!           -comment {tableau 2d double precision} 
!
!
!PALM_OBJECT -name matriz\
!            -space mat1d\
!            -intent IN\
!            -comment {matrice 2d}
!


SUBROUTINE print
         
      USE palmlib             ! interface PALM
      USE palm_user_param     ! constantes de Prepalm
      IMPLICIT NONE

      CHARACTER(LEN=PL_LNAME) :: cl_object, cl_space
  
      DOUBLE PRECISION :: dl_mat(IP_SIZE)
      integer :: il_vect_time, i, il_err
       
       
      
!     Recepcion de informacion
      cl_space  = 'mat1d'
      cl_object = 'matriz'
      CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dl_mat, il_err)

      IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Error codigo 2 '
       
      ENDIF



!     Muestra en pantalla

      Write(PL_OUT,*) ' '
      Write(PL_OUT,*) 'Valores de la Ecuacion de Calor en el Codigo No. 2' 
      Write(PL_OUT,*) (dl_mat(i), i=0, IP_SIZE)

END SUBROUTINE print

!
!
!
!
!
!
!
!M.I. Miguel Angel Rodriguez Flores

!PALM_UNIT -name difusion2\
!          -functions {F90 difusion}\
!          -object_files {difusion2.o}\
!          -comment {ecuacion de calor}
!
! 
!PALM_SPACE -name mat1d\
!           -shape (IP_SIZE) \
!           -element_size PL_DOUBLE_PRECISION\
!           -comment {double precision} 
!
!
!PALM_OBJECT -name matriz\
!            -space mat1d\
!            -intent IN\
!            -comment {matriz 1d}
!


SUBROUTINE difusion
        USE palmlib
        USE palm_user_param
        IMPLICIT NONE
              
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dla_mat(IP_SIZE)
        integer :: vect_time, il_err,i
  
      


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!       OPALM       
!       Recepcion de informacion
!
        cl_space  = 'mat1d'
        cl_object = 'matriz'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dla_mat, il_err)
        Write(PL_OUT,*) ' '
        Write(PL_OUT,*) 'Valores Enviados a la barra No.2'
        Write(PL_OUT,*) (dla_mat(i), i=1, IP_SIZE)

!
!
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Error Recepcion de Datos para continuar con la barra No.2 '
        ENDIF
                
!            
        
END SUBROUTINE difusion

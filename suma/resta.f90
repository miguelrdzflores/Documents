!
!
!
!
!
!
!
!M.I. Miguel Angel Rodriguez Flores

!PALM_UNIT -name resta\
!          -functions {F90 resta}\
!          -object_files {resta.o}\
!          -comment {resta}
!
! 
!PALM_SPACE -name mat1d\
!           -shape (1) \
!           -element_size PL_AUTO_SIZE\
!           -comment {double precision} 
!
!
!PALM_OBJECT -name matriz\
!            -space mat1d\
!            -intent IN\
!            -comment {matriz 1d}
!

SUBROUTINE resta
        USE palmlib
        USE palm_user_param
!PROGRAM suma        
        IMPLICIT NONE
        REAL :: c,d,Y


        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dla_mat(IP_SIZE)
        integer :: vect_time, il_err

!       OPALM       
!       Recepcion de informacion
!
        cl_space  = 'mat1d'
        cl_object = 'matriz'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dla_mat, il_err)
        Write(PL_OUT,*) ' '
        Write(PL_OUT,*) 'Valores Enviados a Codigo2'
        Write(PL_OUT,*) dla_mat
   
!
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Error Codigo2'
        ENDIF

        b= 1.0
        c= 1.0
        Y= b+c-dla_mat 
        WRITE(*,'(a,e12.5)')"VALOR DE Y= ",Y


END SUBROUTINE 	resta
!END PROGRAM suma

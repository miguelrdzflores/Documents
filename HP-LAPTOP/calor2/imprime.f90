!
!
!
!
!
!
!
!
!
!PALM_UNIT -name imprime\
!          -functions {F90 imprime}\
!          -object_files {imprime.o}\
!          -comment {imprime}
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



SUBROUTINE imprime
        USE palmlib
        USE palm_user_param
        IMPLICIT NONE
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dla_mat(IP_SIZE)
        integer :: vect_time, il_err,i
        
        cl_space  = 'mat1d'
        cl_object = 'matriz'
        CALL PALM_Get(cl_space, cl_object, vect_time, dla_mat, il_err)

        WRITE (PL_OUT,*) 'DATOS RECIBIDOS DESDE CODIGO No. 1'
        WRITE(PL_OUT,*) ' '
        WRITE(PL_OUT,*)(dla_mat(i), i=1, IP_SIZE)
        WRITE(PL_OUT,*) ' '
END SUBROUTINE imprime
	






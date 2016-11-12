!
!
!
!
!
!
!
!M.I. Miguel Angel Rodriguez Flores

!PALM_UNIT -name suma\
!          -functions {F90 suma}\
!          -object_files {suma.o}\
!          -comment {suma}
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
!            -intent OUT\
!            -comment {matriz 1d}
!

SUBROUTINE suma
       USE palmlib
       USE palm_user_param
       
       IMPLICIT NONE
       REAL :: a,b,X
        

       CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
       DOUBLE PRECISION, ALLOCATABLE:: dla_mat (:)
       INTEGER :: il_err, il_size
       INTEGER, ALLOCATABLE :: buffer(:)

       a= 1.0
       b= 2.0 
       X=a+b
       WRITE(*,'(a,e12.5)')"VALOR DE X= ",X
       dla_mat= X

!Envio de la matriz 
       cl_space = 'mat1d'
       cl_object = 'matriz'
       CALL PALM_Put (cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dla_mat, il_err)
        
       IF (il_err.ne.0) THEN
          WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
       CALL PALM_Abort(il_err)
       ENDIF
                
       
END SUBROUTINE suma







!
!
!
!
!
!
!
!M.I. Miguel Angel Rodriguez Flores

!PALM_UNIT -name difusion\
!          -functions {F90 difusion}\
!          -object_files {difusion.o GlobalData.o Data_in_out.o solver.o}\
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
!            -intent OUT\
!            -comment {matriz 1d}
!


SUBROUTINE difusion
        USE GlobalData
        USE Data_in_out
        USE solver
        USE palmlib
        USE palm_user_param
        IMPLICIT NONE
        REAL, ALLOCATABLE :: X(:),T(:)
      
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dla_mat(IP_SIZE)
        integer :: vect_time, il_err
  
      
!       Lee los parametros del archivo param.in

        CALL input_data (delta_x,x_min,x_max,delta_t,kappa,bound_left,bound_right,nx,timestep)
        WRITE(PL_OUT,*)"Resuelve la ecuacion en el dominio"
        WRITE(PL_OUT,'(e12.5,a,e12.5)')x_min," < x < ",x_max
        
        WRITE(PL_OUT,*)"Con",nx," puntos en direccion x"
        WRITE(PL_OUT,*)"delta X= ",delta_x
        WRITE(PL_OUT,'(a,e12.5)')"El valor de kappa es ",kappa
        WRITE(PL_OUT,'(a,e12.5)')"El valor de la frontera izquierda  es ",bound_left
        WRITE(PL_OUT,'(a,e12.5)')"El valor de la frontera derecha  es ",bound_right


!       Crea matriz
        ALLOCATE (X(0:nx),T(0:nx))

!       inicializa valores
        CALL initial_values (x_min,nx,X,delta_x,delta_t,kappa,lambda,T,bound_left,bound_right)
        WRITE(PL_OUT,'(a,e12.5)')"El valor de Lambda ",lambda
        WRITE (PL_OUT,*)"Condiciones iniciales"
        WRITE (PL_OUT,'(7x,a,15X,a)')"X","T"
        DO i=0,nx-1
          write(PL_OUT,'(e12.5,5X,e12.5)')X(i),T(i)
        ENDDO

!       Resuelve la matriz
        CALL solver1d (nx,T,lambda,bound_left,bound_right,timestep)

        
        WRITE (PL_OUT,*)"Resultados"
        WRITE (PL_OUT,'(7x,a,15X,a)')"X","T"
        DO i=0,nx-1
          write(PL_OUT,'(e12.5,5X,e12.5)')X(i),T(i)           
          dla_mat (i+1)= T(i) 
        ENDDO
!       Envio de la matriz 
        cl_space = 'mat1d'
        cl_object = 'matriz'
        CALL PALM_Put (cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dla_mat, il_err)
        
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
        CALL PALM_Abort(il_err)
        ENDIF   

        
        WRITE (PL_OUT,*)"Los resultados se encuentran el archivo resultados_barra1.out"        
!       Escribe los resultados en el archivo resultados.out     
        Call ouput_data (X,T,nx)

END SUBROUTINE difusion

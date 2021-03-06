!
!
!
!
!
!
!
!Autor: M.I. MIGUEL ANGEL RODRIGUEZ FLORES
!PALM_UNIT -name calor1d_2\
!          -functions {F90 calor1d}\
!          -object_files {calor1d_2.o globaldata.o}\
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

SUBROUTINE calor1d
	USE globaldata
        USE palmlib
        USE palm_user_param
	IMPLICIT NONE
        REAL :: delta_x, x_min,x_max,t_min,t_max,delta_t, kappa, cfl,lambda,time 
        REAL, ALLOCATABLE :: X(:), U(:), U_update(:)
        INTEGER :: N,T,i,j,k 
        CHARACTER(LEN=20) :: filename   
!******DECLARACIONES Y CONSTANTES DE OPALM**************************************
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dla_mat(IP_SIZE)
        integer :: vect_time, il_err  

!*****RECEPCION DE INFORMACION DE OPALM****************************************

        cl_space  = 'mat1d'
        cl_object = 'matriz'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dla_mat, il_err)
        Write(PL_OUT,*) ' '
        Write(PL_OUT,*) 'Valores Enviados a la barra No.2'
        Write(PL_OUT,*) (dla_mat(i), i=1, IP_SIZE)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Error Recepcion de Datos para continuar con la barra No.2 '
        ENDIF

!**************PARAMETROS DE ECUACION DE CALOR 1D*********************************
        x_min = 0.4545454545 
        x_max = 1.00
        t_min = 0.00
        t_max = 0.20
        kappa = 0.0625
            N = 5
            T = 5  

!*************FIN DE PARAMETROS DE ECUACION DE CALOR 1D***************************

       delta_x = (x_max - x_min)/ (N + 1)  
       delta_t = (t_max - t_min)/ (T + 1)
       lambda = kappa * (delta_t/delta_x)/delta_x
       cfl = kappa * delta_t/delta_x/delta_x
       ALLOCATE (X(0:N+1),U(0:N+1),U_update(0:N+1))
!*********************************************************************************
      WRITE (*,'(a)')''
      WRITE (*,'(a)')'ECUACIÓN DE CALOR EN UNA SOLA DIMENSION (X)'
      WRITE (*,'(a)')'dU/dt - K * d2U/dx2 = f(x,t)'
      WRITE (*,'(a)')''
      WRITE (*,'(a)')'Resuelve la ecuacion en el dominio'
      WRITE(*,'(e12.5,a,e12.5)')x_min," < x < ",x_max
      WRITE(*,*)"Con",N," puntos en direccion x"
      WRITE(*,'(a,e12.5)')"El valor de delta x es ",delta_x 
      WRITE(*,'(a,e12.5)')"El valor de delta t es ",delta_t
      WRITE(*,'(a,e12.5)')"El valor de kappa es ",kappa
      WRITE(*,'(a,e12.5)')"El valor de CFL ",cfl
      
!*********************Escribe en OPALM******************************************
      WRITE (PL_OUT,'(a)')''
      WRITE (PL_OUT,'(a)')'ECUACIÓN DE CALOR EN UNA SOLA DIMENSION (X)'
      WRITE (PL_OUT,'(a)')'dU/dt - K * d2U/dx2 = f(x,t)'
      WRITE (PL_OUT,'(a)')''
      WRITE (PL_OUT,'(a)')'Resuelve la ecuacion en el dominio'
      WRITE(PL_OUT,'(e12.5,a,e12.5)')x_min," < x < ",x_max
      WRITE(PL_OUT,*)"Con",N," puntos en direccion x"
      WRITE(PL_OUT,'(a,e12.5)')"El valor de delta x es ",delta_x
      WRITE(PL_OUT,'(a,e12.5)')"El valor de delta t es ",delta_t
      WRITE(PL_OUT,'(a,e12.5)')"El valor de kappa es ",kappa
      WRITE(PL_OUT,'(a,e12.5)')"El valor de CFL ",cfl




!*************Establece valores de X**********************************************
       DO k= 0, N+1
          X(k)= x_min + dble(k)*delta_x
       ENDDO
!*************** Establece condiciones iniciales
!       U(0) = dla_mat(5)
!       DO i= 1,N
!          U(i)=initial_value(X(i))
!       ENDDO
!       U(N+1)= 0.0
        U(0:N+1)= dla_mat(5:IP_SIZE)
!****************Escribe condciones iniciales en pantalla***************************
        WRITE (*,*)"Condiciones iniciales"
        WRITE (*,'(7x,a,15X,a)')"X","U"
        WRITE (PL_OUT,*)"Condiciones iniciales"
        WRITE (PL_OUT,'(7x,a,15X,a)')"X","U"
        OPEN (UNIT=5, file="resultadosb20.out", ACTION="write", STATUS="replace")
        WRITE(5,'(a,e12.5)')"#Tiempo=  ", t_min
        WRITE(PL_OUT,'(a,e12.5)')"#Tiempo=  ", t_min 
        DO i=0,N + 1 
          WRITE(*,'(e12.5,5X,e12.5)')X(i),U(i)
          WRITE(5,'(e12.5,5X,e12.5)')X(i),U(i)
          WRITE(PL_OUT,'(e12.5,5X,e12.5)')X(i),U(i)
        ENDDO
        CLOSE(5)

!****************Resuelve esquema Euler*********************************************
       
             
       DO i=1, T + 1
          time = t_min + i*delta_t
          WRITE(filename,"('resultadosb2',I0,'.out')")i
          OPEN (UNIT=7, file= filename, ACTION="write", STATUS="replace")
          WRITE(*,'(a,e12.5)')"Tiempo=  ", t_min + dble(i)*delta_t          
          WRITE(7,'(a,e12.5)')"#Tiempo=  ", t_min + dble(i)*delta_t
          WRITE(PL_OUT,'(a,e12.5)')"#Tiempo=  ", t_min + dble(i)*delta_t
          DO j=1, N               
             U_update(j)= U(j)+ lambda*(U(j-1)-2*U(j)+U(j+1))             
          END DO
          U_update(0)=dla_mat(5)
          U_update(N+1)=0.0
          U(0:N+1) = U_update(0:N+1)
          
          DO K=0,N+1 
             WRITE(*,'(e12.5,5X,e12.5)')X(k),U(k)
             WRITE(7,'(e12.5,5X,e12.5)')X(k),U(k)
             WRITE(PL_OUT,'(e12.5,5X,e12.5)')X(k),U(k)             
          ENDDO
          CLOSE(7)           
       ENDDO
       
     
CONTAINS
!REAL FUNCTION boundary_condition (time)
!     IMPLICIT NONE
!     REAL, INTENT (IN) :: time
!    boundary_condition = 0.0   
!     boundary_condition = 0.0
!END FUNCTION boundary_condition





 REAL FUNCTION initial_value(x)
     IMPLICIT NONE
     REAL, INTENT (IN) :: x
!     initial_value = 0
     initial_value = 2 * sin (2 * pi *x)
 END FUNCTION initial_value

 
      

END SUBROUTINE calor1d

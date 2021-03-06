!
!
!
!
!
!
!
!Autor: M.I. MIGUEL ANGEL RODRIGUEZ FLORES
!PALM_UNIT -name condiciones\
!          -functions {F90 condiciones}\
!          -object_files {condiciones.o globaldata.o}\
!          -comment {condiciones iniciales}


!PALM_SPACE -name vect1d\
!           -shape (IP_SIZE)\
!           -element_size PL_DOUBLE_PRECISION\
!           -comment {tableau 1d double precision} 
!
!
!PALM_OBJECT -name vecteur_u\
!            -space vect1d\
!            -intent OUT\
!            -comment {Vector_U}
!
!PALM_OBJECT -name vecteur_x\
!            -space vect1d\
!            -intent OUT\
!            -comment {Vecteur_X}
!
!PALM_OBJECT -name t_min\
!            -space one_double\
!            -intent OUT\
!            -comment {tmin}
!
!PALM_OBJECT -name delta_t\
!            -space one_double\
!            -intent OUT\
!            -comment {delta_t}
!
!PALM_OBJECT -name lambda\
!            -space one_double\
!            -intent OUT\
!            -comment {lambda}



SUBROUTINE condiciones
        USE globaldata
        USE palmlib
        USE palm_user_param
        REAL :: x_min,x_max,t_max,kappa,delta_x,cfl
        INTEGER :: N,T
        REAL, ALLOCATABLE :: X(:), U(:), U_update(:)

!******DECLARACIONES Y CONSTANTES DE OPALM**************************************
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: dlavect_x(IP_SIZE),dlavect_u(IP_SIZE),delta_t,t_min,lambda
        integer ::il_vect_time, il_err

!**************PARAMETROS DE ECUACION DE CALOR 1D*********************************
        x_min = 0.00
        x_max = 1.00
        t_min = 0.00
        t_max = 0.20
        kappa = 0.0625
            N = 10 
            T = 5
!***********************************************************************************
       delta_x = (x_max - x_min)/ (N + 1)
       delta_t = (t_max - t_min)/ (T + 1)
       lambda = kappa * (delta_t/delta_x)/delta_x
       cfl = kappa * delta_t/delta_x/delta_x
       ALLOCATE (X(0:N+1),U(0:N+1),U_update(0:N+1))
!**********************Envio Palm****************************************************
         
        cl_space  = 'one_double'
        cl_object = 'delta_t'
        CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, delta_t, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
           CALL PALM_Abort(il_err)
        ENDIF
        
        
        cl_space  = 'one_double'
        cl_object = 't_min'
        CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, t_min, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
           CALL PALM_Abort(il_err)
        ENDIF

           
        cl_space  = 'one_double'
        cl_object = 'lambda'
        CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, lambda, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
           CALL PALM_Abort(il_err)
        ENDIF

!**************Escribe en Pantalla***************************************************
      WRITE (6,'(a)')''
      WRITE (6,'(a)')'ECUACIÓN DE CALOR EN UNA SOLA DIMENSION (X)'
      WRITE (6,'(a)')'dU/dt - K * d2U/dx2 = f(x,t)'
      WRITE (6,'(a)')''
      WRITE (6,'(a)')'Resuelve la ecuacion en el dominio'
      WRITE(6,'(e12.5,a,e12.5)')x_min," < x < ",x_max
      WRITE(6,*)"Con",N," puntos en direccion x"
      WRITE(6,'(a,e12.5)')"El valor de delta x es ",delta_x
      WRITE(6,'(a,e12.5)')"El valor de delta t es ",delta_t
      WRITE(6,'(a,e12.5)')"El valor de kappa es ",kappa
      WRITE(6,'(a,e12.5)')"El valor de CFL ",cfl

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
!*************** Establece condiciones iniciales*************************************


       U(0) =0.0
       DO i= 1,N
          U(i)=initial_value(X(i))
       ENDDO
       U(N+1)= 0.0


!****************Escribe condciones iniciales en pantalla***************************
        WRITE (6,*)"Condiciones iniciales"
        WRITE (6,'(7x,a,15X,a)')"X","U"
        WRITE (PL_OUT,*)"Condiciones iniciales"
        WRITE (PL_OUT,'(7x,a,15X,a)')"X","U"
        OPEN (UNIT=5, file="resultados0.out", ACTION="write", STATUS="replace")
        WRITE(5,'(a,e12.5)')"#Tiempo=  ", t_min
        WRITE(PL_OUT,'(a,e12.5)')"#Tiempo=  ", t_min
        DO i=0,N + 1
          WRITE(6,'(e12.5,5X,e12.5)')X(i),U(i)
          WRITE(5,'(e12.5,5X,e12.5)')X(i),U(i)
          WRITE(PL_OUT,'(e12.5,5X,e12.5)')X(i),U(i)
        ENDDO
        CLOSE(5)
!**************Envia condiciones iniciales******************************************
        dlavect_u(1:N+2)= U(0:N+1)
        dlavect_x(1:N+2)= X(0:N+1)
        
        cl_space  = 'vect1d'
        cl_object = 'vecteur_x'
        
        CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dlavect_x, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
           CALL PALM_Abort(il_err)
        ENDIF

        cl_space  = 'vect1d'
        cl_object = 'vecteur_u'      
        CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dlavect_u, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
           CALL PALM_Abort(il_err)
        ENDIF

CONTAINS

 REAL FUNCTION initial_value(x)
     IMPLICIT NONE
     REAL, INTENT (IN) :: x
!     initial_value = 0
     initial_value = 2 * sin (2 * pi *x)
 END FUNCTION initial_value

END SUBROUTINE condiciones

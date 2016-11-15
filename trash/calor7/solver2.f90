!
!
!
!
!
!
!
!Autor: M.I. MIGUEL ANGEL RODRIGUEZ FLORES
!PALM_UNIT -name solver2\
!          -functions {F90 solver2}\
!          -object_files {solver2.o globaldata.o}\
!          -comment {solver ec. calor esquema euler}
!
!PALM_SPACE -name vect1d\
!           -shape (IP_SIZE) \
!           -element_size PL_DOUBLE_PRECISION\
!           -comment {double precision} 
!
!PALM_OBJECT -name U\
!            -space vect1d\
!            -intent IN\
!            -comment {Vector_U}
!
!PALM_OBJECT -name X\
!            -space vect1d\
!            -intent IN\
!            -comment {Vecteur_X}
!
!PALM_OBJECT -name delta_t\
!            -space one_double\
!            -intent IN\
!            -comment {delta_t}
!
!PALM_OBJECT -name lambda\
!            -space one_double\
!            -intent IN\
!            -comment {lambda}
!
!PALM_OBJECT -name time\
!            -space one_double\
!            -intent in\
!            -comment {tiempo}


SUBROUTINE solver2
        USE globaldata
        USE palmlib
        USE palm_user_param
        IMPLICIT NONE
        REAL :: delta_x, x_min,x_max,t_max, kappa, cfl
        DOUBLE PRECISION :: U_update(IP_SIZE),u_min, u_max,time
        
        INTEGER :: N,T,i,j,k
        CHARACTER(LEN=20) :: filename
!******DECLARACIONES Y CONSTANTES DE OPALM**************************************
        CHARACTER (LEN=PL_LNAME) :: cl_object, cl_space
        DOUBLE PRECISION :: X(IP_SIZE),U(IP_SIZE),delta_t,t_min,lambda
        integer ::il_vect_time, il_err, il_shape

        N = 10

        cl_space  = 'one_double'
        cl_object = 'time'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, time, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en Get de solver ,time'
           CALL PALM_Abort(il_err)
        ENDIF
       
        
        cl_space = 'one_double'
        cl_object = 'delta_t'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, delta_t, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en Get de solver , delta_t'
           CALL PALM_Abort(il_err)
        ENDIF
       
!        WRITE(PL_OUT,'(a,e12.5)')"El valor de delta t en solver es ",delta_t

        cl_space = 'one_double'
        cl_object = 'lambda'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, lambda, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en Get de solver , lambda'
           CALL PALM_Abort(il_err)
        ENDIF
    
!        WRITE(PL_OUT,'(a,e12.5)')"El valor de lambda en solver es ",lambda
        
      
              
        cl_space  = 'vect1d'
        cl_object = 'X'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, X, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en Get de solver, X'
           CALL PALM_Abort(il_err)
        ENDIF
!        WRITE (PL_OUT,*) 'DATOS RECIBIDOS DESDE CODIGO No. 1, X'
!        WRITE(PL_OUT,*)(X(i), i=1, IP_SIZE) 


                   
        cl_space  = 'vect1d'
        cl_object = 'U'
        CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, U, il_err)
        IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en Get de solver , U'
           CALL PALM_Abort(il_err)
        ENDIF
!        WRITE (PL_OUT,*) 'DATOS RECIBIDOS DESDE CODIGO No. 1, U' 
!        WRITE(PL_OUT,*)(U(i), i=1, IP_SIZE)
 
        u_min= U(1)
        u_max= U(N+2)  
!******************esquema de Euler**************************************
        WRITE (6,'(a)')''
        WRITE (6,'(a)')''
        WRITE (PL_OUT,'(a)')'Refinamiento'
        WRITE(6,'(a,e12.5)')"Tiempo=  ", time
        WRITE(PL_OUT,'(a,e12.5)')"#Tiempo=  ", time
        
        DO j=2, N+1
                U_update(j)= U(j)+ lambda*(U(j-1)-2*U(j)+U(j+1))
        END DO
        U_update(1)=u_min
        U_update(N+2)= u_max
        

        WRITE(filename,"('refin_',F0.3,'.out')")time
        OPEN (UNIT=8, file=filename, ACTION="write", STATUS="replace")
        WRITE(8,'(a,e12.5)')"#Tiempo=  ", time

        DO K=1,N+2
               WRITE(6,'(e12.5,5X,e12.5)')X(k),U_update(k)
               WRITE(PL_OUT,'(e12.5,5X,e12.5)')X(k),U_update(k)
               WRITE(8,'(e12.5,5X,e12.5)')X(k),U_update(k)
        ENDDO
        CLOSE(8)
        WRITE (PL_OUT,'(a)')''
        WRITE (6,'(a)')''
        WRITE (6,'(a)')''
        WRITE (6,'(a)')'--------------------------------------------------------------'
END SUBROUTINE solver2

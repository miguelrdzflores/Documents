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

!PALM_UNIT -name vecteur_print\
!          -functions {F90 vecteur_print}\
!          -object_files {vecteur_print.o}\
!          -comment {vecteur_print}
!
!PALM_SPACE -name vect1d\
!           -shape (IP_SIZE)\
!           -element_size PL_DOUBLE_PRECISION\
!           -comment {tableau 1d double precision}
!
!PALM_OBJECT -name X\
!            -space NULL\
!            -intent IN\
!            -comment {vecteur 1d}

!PALM_OBJECT -name U\
!            -space NULL\
!            -intent IN\
!            -comment {vecteur 1d}
!
!PALM_OBJECT -name Nmin\
!            -space one_integer\
!            -intent in\
!            -comment {nmin}
!
!PALM_OBJECT -name Nmax\
!            -space one_integer\
!            -intent in\
!            -comment {nmax}
!
!PALM_OBJECT -name n_nest\
!            -space one_integer\
!            -intent in\
!            -comment {nnest}
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
!PALM_OBJECT -name delta_t\
!            -space one_double\
!            -intent OUT\
!            -comment {delta_t}
!
!PALM_OBJECT -name lambda\
!            -space one_double\
!            -intent OUT\
!            -comment {lambda}
!
!PALM_OBJECT -name time\
!            -space one_double\
!            -intent IN\
!            -comment {lambda}

!PALM_OBJECT -name time_ref\
!            -space one_double\
!            -intent out\
!            -comment {lambda}







SUBROUTINE vecteur_print

  USE palmlib             ! interface PALM
  USE palm_user_param     ! constantes de Prepalm

  IMPLICIT NONE

  CHARACTER(LEN=PL_LNAME) :: cl_object, cl_space
  
  DOUBLE PRECISION, ALLOCATABLE :: X(:), U(:), X_ref(:), U_ref(:) 
  DOUBLE PRECISION x_min, x_max, delta_x, delta_t, lambda, cfl, kappa, t_max, t_min, T, u_min, u_max 
  DOUBLE PRECISION dlavect_x(IP_SIZE),dlavect_u(IP_SIZE), time, time_ref  
  integer ::  i, il_err, il_shape, Nmin, Nmax, n_nest, N, k
  CHARACTER(LEN=20) :: filename 

!l'espace a ete declare NULL, pour savoir quel est l'espace herite 
! il faut appeler la primitive Object_get_spacename
  cl_object = 'X'
  call PALM_Object_get_spacename(cl_object, cl_space, il_err)


! on peut maintenant connaitre la taille de l'espace
!( on sait que le rang est 1)
  CALL PALM_Space_get_shape(cl_space, 1, il_shape, il_err)
  ALLOCATE(X(il_shape))



! reception du vecteur
  cl_space  = 'NULL'
  cl_object = 'X'
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, X, il_err)

! ecriture

  WRITE(PL_OUT,*) ' '
!  WRITE(PL_OUT,*) 'Valores de X :'
!  WRITE(PL_OUT,*) (X(i), i=1,il_shape )

 
  
  cl_object = 'U'
  call PALM_Object_get_spacename(cl_object, cl_space, il_err)

  CALL PALM_Space_get_shape(cl_space, 1, il_shape, il_err)
  ALLOCATE(U(il_shape))

  cl_space  = 'NULL'
  cl_object = 'U'
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, U, il_err)

 ! WRITE(PL_OUT,*) ' '
 ! WRITE(PL_OUT,*) 'Valores de U :'
 ! WRITE(PL_OUT,*) (U(i), i=1,il_shape )


  cl_space  = 'one_integer'
  cl_object = 'Nmin'
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, Nmin, il_err)
  IF (il_err.ne.0) THEN
       WRITE(PL_OUT, *) 'Ha ocurrido un error en condiciones2 ,Nmin'
       CALL PALM_Abort(il_err)
  ENDIF
  

  cl_space  = 'one_integer'
  cl_object = 'Nmax'
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, Nmax, il_err)
  IF (il_err.ne.0) THEN
       WRITE(PL_OUT, *) 'Ha ocurrido un error en condiciones2 ,Nmax'
       CALL PALM_Abort(il_err)
  ENDIF
   
   
  cl_space  = 'one_integer'
  cl_object = 'n_nest'
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, n_nest, il_err)
  IF (il_err.ne.0) THEN
       WRITE(PL_OUT, *) 'Ha ocurrido un error en condiciones2 ,Nmax'
       CALL PALM_Abort(il_err)
  ENDIF

  cl_space  = 'one_double'
  cl_object = 'time'
  CALL PALM_GET(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, time, il_err)
  IF (il_err.ne.0) THEN
        WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
        CALL PALM_Abort(il_err)
  ENDIF



!*********PARAMETROS DE ECUACION DE CALOR********************
  
  x_min = X(Nmin)
  x_max = X(Nmax)
  
  t_max = 0.20
  kappa = 0.0625
  T = 5
  N = n_nest 
  u_min = U(Nmin) 
  u_max = u(Nmax)
!*******************************************************************
  delta_x = (x_max - x_min)/(n_nest+1)
  delta_t = (t_max - t_min)/ (T + 1)
  lambda = kappa * (delta_t/delta_x)/delta_x
  cfl = kappa * delta_t/delta_x/delta_x
!**************Escribe en Pantalla***************************************************
  WRITE (6,'(a)')''
  WRITE (6,'(a)')'REFINAMIENTO DEL DOMINIO DE LA ECUACIÓN DE CALOR EN UNA SOLA DIMENSION (X)'
  WRITE (6,'(a)')'dU/dt - K * d2U/dx2 = f(x,t)'
  WRITE (6,'(a)')''
  WRITE (6,'(a)')'Resuelve la ecuacion en el dominio'
  WRITE(6,'(e12.5,a,e12.5)')x_min," < x < ",x_max
  WRITE(6,*)"Con",N," puntos en direccion x"
  WRITE(6,'(a,e12.5)')"El valor de delta x es ",delta_x
  WRITE(6,'(a,e12.5)')"El valor de delta t es ",delta_t
  WRITE(6,'(a,e12.5)')"El valor de kappa es ",kappa
  WRITE(6,'(a,e12.5)')"El valor de CFL ",cfl  

  WRITE (6,'(a)')''
  WRITE (6,'(a)')''


!*********************Escribe en OPALM******************************************
  WRITE (PL_OUT,'(a)')''
  WRITE (PL_OUT,'(a)')'REFINAMIENTO DEL DOMINIO DE LA ECUACIÓN DE CALOR EN UNA SOLA DIMENSION (X)'
  WRITE (PL_OUT,'(a)')'dU/dt - K * d2U/dx2 = f(x,t)'
  WRITE (PL_OUT,'(a)')''
  WRITE (PL_OUT,'(a)')'Resuelve la ecuacion en el dominio'
  WRITE(PL_OUT,'(e12.5,a,e12.5)')x_min," < x < ",x_max
  WRITE(PL_OUT,*)"Con",N," puntos en direccion x"
  WRITE(PL_OUT,'(a,e12.5)')"El valor de delta x es ",delta_x
  WRITE(PL_OUT,'(a,e12.5)')"El valor de delta t es ",delta_t
  WRITE(PL_OUT,'(a,e12.5)')"El valor de kappa es ",kappa
  WRITE(PL_OUT,'(a,e12.5)')"El valor de CFL ",cfl
 
  WRITE (PL_OUT,'(a)')''
  WRITE (PL_OUT,'(a)')''

!*************Establece valores de X**********************************************
  ALLOCATE (X_ref(1:N+2))
  DO k= 0, N+1
  X_ref(k+1)= x_min + dble(k)*delta_x
  ENDDO

!***********Establece condiciones iniciales***************************************
  ALLOCATE (U_ref(1:N+2))
  U_ref(1)= U(Nmin)
  DO i= 2,N+1
     U_ref(i)= initial_value(X_ref(i), u_min,u_max, x_min, x_max)
  ENDDO
  U_ref(N+2)= U(Nmax)
!
!****************Escribe condciones iniciales en pantalla***************************
  WRITE (6,*)"Condiciones iniciales"
  WRITE (6,'(7x,a,15X,a)')"X","U"
  WRITE (PL_OUT,*)"Condiciones iniciales"
  WRITE (PL_OUT,'(7x,a,15X,a)')"X","U"
  
  WRITE(filename,"('c_ref_',F0.3,'.out')")time 
  OPEN (UNIT=7, file=filename, ACTION="write", STATUS="replace")
    
  WRITE(7,'(a,e12.5)')"#Tiempo=  ", time
  WRITE(PL_OUT,'(a,e12.5)')"#Tiempo=  ", time
  DO i=1,N + 2
     WRITE(6,'(e12.5,5X,e12.5)')X_ref(i),U_ref(i)
     WRITE(7,'(e12.5,5X,e12.5)')X_ref(i),U_ref(i)
     WRITE(PL_OUT,'(e12.5,5X,e12.5)')X_ref(i),U_ref(i)
  ENDDO
  CLOSE(7)

  
  DEALLOCATE(X)
  DEALLOCATE(U)
!***********ENVIA CONDCIONES INICIALES*********************************************
  
  dlavect_u(1:N+2)= U_ref(1:N+2)
  dlavect_x(1:N+2)= X_ref(1:N+2)
  time_ref = time

  cl_space  = 'vect1d'
  cl_object = 'vecteur_x'

  CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dlavect_x, il_err)
  IF (il_err.ne.0) THEN
           WRITE(PL_OUT, *) 'Ha ocurrido un error en el envio de las condiciones iniciales del refinamiento,x'
           CALL PALM_Abort(il_err)
  ENDIF

  cl_space  = 'vect1d'
  cl_object = 'vecteur_u'
  CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, dlavect_u, il_err)
  IF (il_err.ne.0) THEN
       WRITE(PL_OUT, *) 'Ha ocurrido un error en el envio de las condiciones iniciales del refinamiento,U'
       CALL PALM_Abort(il_err)
  ENDIF

  cl_space  = 'one_double'
  cl_object = 'delta_t'
  CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, delta_t, il_err)
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

  cl_space  = 'one_double'
  cl_object = 'time_ref'
  CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, time_ref, il_err)
  IF (il_err.ne.0) THEN
        WRITE(PL_OUT, *) 'Ha ocurrido un error en codigo No. 1'
        CALL PALM_Abort(il_err)
  ENDIF


CONTAINS
 REAL FUNCTION initial_value(x,u_min, u_max, x_min, x_max)
     IMPLICIT NONE
     DOUBLE PRECISION, INTENT (IN) :: x, u_min, u_max, x_min, x_max
     initial_value = (u_max-u_min)*(x - x_min) / (x_max-x_min) + u_min
 END FUNCTION initial_value


END SUBROUTINE vecteur_print



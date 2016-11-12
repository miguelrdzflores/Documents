!
!
!
!
!
!
!
MODULE solver
   CONTAINS
     SUBROUTINE initial_values (x_min,nx,X,delta_x,delta_t,kappa,lambda,T,bound_left,bound_right)
        IMPLICIT NONE
        INTEGER :: i,j
        INTEGER, INTENT (IN) :: nx
        REAL, INTENT (IN) :: x_min,kappa,delta_x,delta_t,bound_left,bound_right
        REAL, INTENT (OUT) :: X(0:nx),T(0:nx),lambda
        !Asigna los valores del dominio X
        DO i=0, nx-1
             T(i) = 0.0
             X(i) = x_min + dble(i)*delta_x
        ENDDO
        T(0) = bound_left
        T(nx-1) = bound_right
        lambda = kappa * (delta_t/delta_x )/delta_x
     END SUBROUTINE initial_values


! Esquema explicito para u_t = u_xx
     SUBROUTINE solver1d (nx,T,lambda,bound_left,bound_right,timestep)
        IMPLICIT NONE
        INTEGER :: i,j,k
        REAL :: T_temp
        INTEGER, INTENT (IN) :: nx,timestep
        REAL, INTENT (IN) :: lambda,bound_left,bound_right
        REAL, INTENT (INOUT) :: T(0:nx-1)

        DO k=2,timestep
        T(0) = bound_left
         DO i=1, nx-2
           T_temp= T(i) + lambda*(T(i-1) - 2 * T(i) + T(i+1))
           T(i) = T_temp
         ENDDO
        T(nx-1) = bound_right
        ENDDO
     END SUBROUTINE solver1d
     

END MODULE


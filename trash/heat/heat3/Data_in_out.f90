!
!
!
!
!
!
!


MODULE Data_in_out
   CONTAINS
     SUBROUTINE input_data (delta_x,x_min,x_max,delta_t,kappa,bound_left,bound_right,nx,timestep)
        IMPLICIT NONE
        INTEGER, INTENT (OUT) :: nx,timestep
        REAL, INTENT (OUT) :: delta_x,x_min,x_max,delta_t,kappa,bound_left,bound_right
        CHARACTER (LEN=70) :: dummyvar
        OPEN(UNIT=2, file="param.in")
        read(2,*)dummyvar
        read(2,*)delta_x,x_min,x_max,delta_t,timestep,kappa,bound_left,bound_right
        CLOSE(2)
        nx= (x_max - x_min)/ delta_x + 1

     END SUBROUTINE input_data


     SUBROUTINE ouput_data (X,T,nx)
        IMPLICIT NONE
        INTEGER :: i
        REAL, INTENT (IN) :: X(0:nx-1), T(0:nx-1)
        INTEGER, INTENT (IN) :: nx
        OPEN (UNIT=5, file="resultados.out", ACTION="write", STATUS="replace")
        write(5,'(e12.5,5X,e12.5)') (X(i),T(i),i=0,nx-1)
        CLOSE(5)

     END SUBROUTINE ouput_data

END MODULE

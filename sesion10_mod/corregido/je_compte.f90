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

!PALM_UNIT -name je_compte\
!          -functions {F90 je_compte}\
!          -object_files {je_compte.o}\
!          -comment {entiers 1..n}
!
!
!PALM_OBJECT -name n\
!            -space one_integer\
!            -intent IN\
!            -comment {nombre d'entiers}
!
!PALM_OBJECT -name i\
!            -space one_integer\
!            -intent OUT\
!            -comment {entier produit}
!
!PALM_OBJECT -name somme\
!            -space one_integer\
!            -intent in\
!            -comment {entier produit}
!






SUBROUTINE je_compte

  USE palmlib             ! interface PALM

  IMPLICIT NONE

  CHARACTER(LEN=PL_LNAME) :: cl_object, cl_space
  
  integer :: j, n, i, somme,il_err

  cl_space = 'one_integer'

  cl_object = 'n'
  
  CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, n, il_err)
  
  
  cl_object = 'i'
  DO j = 1, n
     IF (j<10) THEN
      i= j
      CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, i, il_err)
     ELSE
      cl_object = 'somme'
      CALL PALM_Get(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, somme, il_err)  
      WRITE(6,*)"desde branch2= ", somme
      i= j 
      CALL PALM_Put(cl_space, cl_object, PL_NO_TIME, PL_NO_TAG, i, il_err)
     ENDIF 
  ENDDO

END SUBROUTINE je_compte


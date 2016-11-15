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
!
!PALM_OBJECT -name vecteur\
!            -time ON\
!            -space NULL\
!            -intent IN\
!            -comment {vecteur 1d}


SUBROUTINE vecteur_print

  USE palmlib             ! interface PALM
  USE palm_user_param     ! constantes de Prepalm

  IMPLICIT NONE

  CHARACTER(LEN=PL_LNAME) :: cl_object, cl_space
  
  DOUBLE PRECISION, ALLOCATABLE :: dla_mat(:)
  integer ::  i, il_err, il_shape, vect_time

!l'espace a ete declare NULL, pour savoir quel est l'espace herite 
! il faut appeler la primitive Object_get_spacename
  cl_object = 'vecteur'
  call PALM_Object_get_spacename(cl_object, cl_space, il_err)


! on peut maintenant connaitre la taille de l'espace
!( on sait que le rang est 1)
  CALL PALM_Space_get_shape(cl_space, 1, il_shape, il_err)
  ALLOCATE(dla_mat(il_shape))



! reception du vecteur
  cl_space  = 'NULL'
  cl_object = 'vecteur'
  CALL PALM_Get(cl_space, cl_object, vect_time, PL_NO_TAG, dla_mat, il_err)

! ecriture

  WRITE(PL_OUT,*) ' '
  WRITE(PL_OUT,*) 'Vecteur_print recu le vecteur :'
  WRITE(PL_OUT,*) (dla_mat(i), i=1,il_shape )

  DEALLOCATE(dla_mat)
  

END SUBROUTINE vecteur_print


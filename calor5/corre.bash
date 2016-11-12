#!/bin/bash

gfortran -c globaldata.f90
make 
mpirun -np 1 ./palm_main
ls

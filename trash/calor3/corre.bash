#!/bin/bash


make 
mpirun -np 1 ./palm_main
ls

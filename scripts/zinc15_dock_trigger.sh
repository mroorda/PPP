#!/bin/bash

# this script takes as input argument a single number
# it iterates from 0 to this number and passes it to
# docking script while submitting the job to slurm

for ((i=0; i<=$1; i++))
do
    sbatch zinc15_dock.sh $i
done

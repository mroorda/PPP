#!/bin/bash

for i in *.mol
do
# retain the part of ligand name before the the period
NAME="${i%.*}.sdf"
echo $NAME

# convert ligand from mol file format to sdf
obabel -imol $i -osdf -O $NAME -as -d # remove hydrogens
obabel -isdf $NAME -osdf -O $NAME --addpolarh # add polar hydrogens

# optimize ligand
# obminimize -n 50 -ff GAFF -o sdf "$NAME-polarH.sdf" > $NAME # minimization
# rm "$NAME-polarH.sdf" # cleanup
done

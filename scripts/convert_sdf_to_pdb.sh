#!/bin/bash

# define vars
SDFS="/home/p275927/PPP/plip/USR-VS/"
PDBS="/home/p275927/PPP/plip/pdbs/"

# change working directory
cd $SDFS

# expand batch ligand sdf to individual sdf
echo "expanding sdf files"
babel hits-USR.sdf -O hits-USR_compound.sdf -m

# rename sdf files to their corresponding ZINC IDs
N=1
for i in *compo*
do
    echo "renaming ${i}"
    mv $i "$(cat $i | head -n 1 | tr -dc '0-9')_${N}.sdf"
    N=$(($N+1))
done

# convert ligand sdf to pdb
babel *.sdf -O .pdb -m

# move pdb files to dedicated folder
mv *.pdb $PDBS

# execute python script that merges ligand and receptor pdbs
echo "executing python script"
python /home/p275927/PPP/plip/scripts/pdb_pymol_merge.py

# change working directory
cd $PDBS

# remove connect records
for i in *.pdb
do
    echo "removing connect records ${i}"
    sed '/CONECT/d' $i > "nocon_${i}"
    rm $i
done

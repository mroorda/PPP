#!/bin/bash

# define vars
SDFS="/data/p275927/USR-VS/ligand_sdf/"
PDBS="/data/p275927/USR-VS/ligand_pdb/"
INFILE="/data/p275927/USR-VS/docked/hits-USRCAT.sdf"

# change working directory
cd $SDFS

# expand batch ligand sdf to individual sdf
echo "unpacking sdf files"
babel $INFILE -O hits-USR_compound.sdf -m

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

# execute python script that merges ligand and receptor pdbs
echo "executing python script"
pymol -c /home/p275927/PPP/scripts/merge_pdb_pymol.py

# cleanup ligand only pdb files which are no longer necessary
rm -rf *.pdb

# change working directory
cd $PDBS

# remove connect records
for i in *.pdb
do
    echo "removing connect records ${i}"
    sed '/CONECT/d' $i > "nocon_${i}"
    rm $i
done

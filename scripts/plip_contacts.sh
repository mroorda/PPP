#!/bin/bash
#SBATCH --job-name=plip
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB

INPUT="/data/p275927/USR-VS/ligand_pdb/USRCAT/"
OUTPUT="/data/p275927/USR-VS/contacts/USRCAT/"

cd $OUTPUT

for i in $(ls $INPUT)
do
    echo $i
    python ~/software/pliptool/plip/plipcmd.py -yvxf "${INPUT}${i}" --name "$i"
done

rm -rf plipfixed*

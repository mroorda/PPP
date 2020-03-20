#!/bin/bash
#SBATCH --job-name=plip
#SBATCH --partition=regular
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB

INPUT="/home/p275927/PPP/plip/pdbs/"
OUTPUT="/home/p275927/PPP/plip/contacts/"

cd $OUTPUT

for i in $(ls $INPUT)
do
    echo $i
    python ~/software/pliptool/plip/plipcmd.py -yvxf "${INPUT}${i}" --name "$i"
done

rm -rf plipfixed*

#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=regular
#SBATCH --time=16:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1GB
#SBATCH --array=1-1000

# slurm array jobs limit is currently 1000 on Peregrine
# array jobs reach into index file containing file names to be run
# SLURM_ARRAY_TASK_ID is used to index these files, as if in a loop

# this script will receive input from a trigger script
# $1 is the input variable passed to this script which indicates the batch number
# batch number is multiplied by the job limit to generate indexes:
# 1-1000, 2-2000 etc
BATCH=$(($1 * 1000))
CHUNK=$(($SLURM_ARRAY_TASK_ID + $BATCH))
DATA="/data/p275927/"
LIGFOLDER="${DATA}ZINC15/data_flat/"
INPUTFILE="${DATA}ZINC15/database/files.txt"
LIGAND=$(sed "${CHUNK}q;d" $INPUTFILE)
RESFOLDER="${DATA}ZINC15/results_nosolvent/"
LOGFOLDER="${DATA}ZINC15/results_nosolvent/logs/"
RECFOLDER="${DATA}receptor/"

echo $BATCH
echo $LIGAND

### run docking
# retain the part of ligand name before the the period (strips the .gz to leave .sdf)
NAME="${LIGAND##*/}"
NAME="${NAME%.*}"
echo $NAME
smina --receptor "${RECFOLDER}4uuu_dimer_nosolvent_SAM-B.pdb" --ligand "${LIGFOLDER}${LIGAND}" \
    --autobox_ligand "${RECFOLDER}SAM_crystal_chainA.sdf" \
    --exhaustiveness 8 --num_modes 5 --cpu 4 --atom_term_data \
    --out "${RESFOLDER}${NAME}" --log "${LOGFOLDER}${NAME}.txt"

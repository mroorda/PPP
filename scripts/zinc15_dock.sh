#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=regular
#SBATCH --time=16:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=1GB
#SBATCH --array=1-987

# use SLURM array task ID to index the ligand file to be run, as if in a loop
BATCH=$(($SLURM_ARRAY_TASK_ID + 0))
DATA="/data/p275927/"
LIGFOLDER="${DATA}ZINC15/data_flat/"
INPUTFILE="${DATA}ZINC15/database/files.txt"
LIGAND=$(sed "${BATCH}q;d" $INPUTFILE)
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

#!/bin/bash
#SBATCH --job-name=dock_profile
#SBATCH --partition=vulture
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1GB
#SBATCH --output=/home/p275927/PPP/outfiles/dock_profile_%j.log
#SBATCH --profile=task

DATA="/data/p275927/"
LIGFOLDER="${DATA}ZINC15/data_flat/"
LIGAND="ZINC15_962.sdf"
RESFOLDER="${DATA}ZINC15/results_nosolvent/"
LOGFOLDER="${DATA}ZINC15/results_nosolvent/logs/"
RECFOLDER="${DATA}receptor/"

echo $LIGAND

### run docking
# retain the part of ligand name before the the period (strips the .gz to leave .sdf)
NAME="${LIGAND##*/}"
NAME="${NAME%.*}"
echo $NAME
smina --receptor "${RECFOLDER}4uuu_dimer_nosolvent_SAM-B.pdb" --ligand "${LIGFOLDER}${LIGAND}" \
    --autobox_ligand "${RECFOLDER}SAM_crystal_chainA.sdf" \
    --exhaustiveness 8 --num_modes 5 --cpu 16 --atom_term_data \
    --out "${RESFOLDER}${NAME}" --log "${LOGFOLDER}${NAME}.txt"

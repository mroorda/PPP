#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=regular
#SBATCH --time=14:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1GB
#SBATCH --array=1-1000

### module load OpenBabel/2.3.2-foss-2016a-Python-2.7.11
### module load Boost/1.61.0-foss-2016a-Python-2.7.11
module list

# use SLURM array task ID to index the ligand file to be run, as if in a loop
BATCH=$(($SLURM_ARRAY_TASK_ID + 0))
LIGFOLDER="/data/p275927/ZINC15/ligands/"
RESFOLDER="/data/p275927/ZINC15/results_nosolvent/"
LOGFOLDER="/data/p275927/ZINC15/results_nosolvent/logs/"
INPUTFILE="/data/p275927/ZINC15/ligands/inputfiles.in"
LIGAND=$(sed "${BATCH}q;d" $INPUTFILE)

echo $BATCH
echo $LIGAND

### run docking
# retain the part of ligand name before the the period (strips the .gz to leave .sdf)
NAME="${LIGAND##*/}"
NAME="${NAME%.*}"
echo $NAME
smina --receptor 4uuu_dimer_nosolvent_SAM-B.pdb --ligand "${LIGFOLDER}${LIGAND}" \
    --autobox_ligand SAM_crystal_chainA.sdf \
    --exhaustiveness 8 --num_modes 5 --cpu 4 --atom_term_data \
    --out "${RESFOLDER}${NAME}" --log "${LOGFOLDER}${NAME}.txt"

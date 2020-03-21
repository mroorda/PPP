#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=regular
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1GB
#SBATCH --array=1-1000

BATCH=$(($SLURM_ARRAY_TASK_ID + 0))

# This script would take each tranch sdf file
# and crate an SDF of each molecule.
# This is not a good approach, since the file
# limit on the peregrine cluster is 1 million
# and the database contains 9 million molecules.
# Probably it is computationally inefficient anyway.
# Do it the other way around - combine the whole database
# into one file and then split it into even chunks.

# use SLURM array task ID to index the ligand file to be run, as if in a loop
LIGFOLDER="/data/p275927/ZINC15/ligands/"
MOLFOLDER="/data/p275927/ZINC15/molecules/"
INPUTFILE="/data/p275927/ZINC15/ligands/inputfiles.in"
LIGAND=$(sed "${BATCH}q;d" $INPUTFILE)
echo "converting $LIGAND"

### extract individual molecules from tranches
babel "${LIGFOLDER}${LIGAND}" -O "${MOLFOLDER}${LIGAND}.sdf" -m

echo "tranch $LIGAND complete"

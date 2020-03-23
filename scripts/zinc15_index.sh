#!/bin/bash
#SBATCH --job-name=zinc_index
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=zinc15_index_%j.log

# define vars
DATADIR="/data/p275927/ZINC15/"
TRANCH="${DATADIR}tranches/*.sdf"
DATABASE="${DATADIR}database/ZINC15.sdf"

# create index file of all ZINC IDs
touch "${DATADIR}index_molecules.txt"
grep -E "ZINC[0-9]{12}" $DATABASE >> $INDFILE

# create index file of downloaded tranch sdf files
touch "${DATADIR}index_sdf_tranches.txt"

# create index file of reformatted sdf files
touch "${DATADIR}index_sdf_reform.txt"

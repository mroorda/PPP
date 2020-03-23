#!/bin/bash
#SBATCH --job-name=zinc_index
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=/home/p275927/PPP/outfiles/zinc15_index_%j.log

# define vars
DATADIR="/data/p275927/ZINC15/"
TRANCH="${DATADIR}tranches/"
DATABASE="${DATADIR}database/ZINC15.sdf"
FLAT="${DATADIR}data_flat/"

# create index file of all ZINC IDs
touch "${DATADIR}index_molecules.txt"
grep -E "ZINC[0-9]{12}" $DATABASE > "${DATADIR}index_molecules.txt"

# create index file of downloaded tranch sdf files
touch "${DATADIR}index_sdf_tranches.txt"
ls $TRANCH > "${DATADIR}index_sdf_tranches.txt"

# create index file of flattened sdf files
touch "${DATADIR}index_sdf_flat.txt"
ls $FLAT > "${DATADIR}index_sdf_flat.txt"

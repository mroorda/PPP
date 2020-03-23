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
TRANCH="${DATADIR}tranches/"
DATABASE="${DATADIR}database/ZINC15.sdf"
METFILE="${DATADIR}metrics.txt"

# create index file of all molecules (ZINC IDs)
touch "${DATADIR}index_molecules.txt"
grep -E "ZINC[0-9]{12}" $DATABASE >> $INDFILE

# count number of molecules
echo "the number of molecules in downloaded database is:"  > $METFILE
grep -E "ZINC[0-9]{12}" $DATABASE | wc -l >> $METFILE

# file sizes of tranch sdf files
echo "file sizes of downloaded tranches:"
ls -s $TRANCH >> $METFILE

# file sizes of reformatted sdf files

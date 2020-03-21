#!/bin/bash
#SBATCH --job-name=zinc_index
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=zinc15_index_%j.log

# this script will split the ZINC15 database
# file into 1000 evenly-sized sdf files

# run code
TRANCH="/data/p275927/ZINC15/tranches/*.sdf"
DATABASE="/data/p275927/ZINC15/database/ZINC15.sdf"
INDFILE="/data/p275927/ZINC15/database/index.txt"

# create index file
touch $INDFILE

# collect all ZINC IDs into the index file
grep -E "ZINC[0-9]{12}" $DATABASE >> $INDFILE


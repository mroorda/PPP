#!/bin/bash
#SBATCH --job-name=zinc_combine
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB

# this script will combine all tranches
# into a single sdf database
# takes 7 min

# run code
TRANCH="/data/p275927/ZINC15/tranches/*.sdf"
DATABASE="/data/p275927/ZINC15/database/ZINC15.sdf"

for i in $TRANCH
do
    cat $i >> $DATABASE
done


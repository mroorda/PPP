#!/bin/bash
#SBATCH --job-name=zinc_gunzip
#SBATCH --partition=vulture
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=4GB

# This takes about 9 min for the whole database
# of 3344 tranches. It also expands the size from
# 5.83G to 40.1G.

# A for loop is used instead of a single *.gz command.
# This is because some of the .gz files fail to unzip.
# The reason is that 44 of them were downloaded as empty
# files, (0B).

# set wd
cd /data/p275927/ZINC15/tranches/

# unzip tranches
for i in *.gz
do
    gunzip $i
done

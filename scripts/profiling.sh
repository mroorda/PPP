#!/bin/bash
#SBATCH --job-name=zinc_count
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=zinc15_numbers.log

# a docking job was run for 4 hours at 4 cpu
# how many compounds did we manage to dock?
# 500 out of 7000

# grep -o 'Refine' hgaaro.log | wc -l
# grep -o '$$$$' ligands/HGAARO.xaa.sdf | wc -l

# how many molecules did we actually download
ZINC=/data/p275927/ZINC15/database/ZINC15.sdf

grep -o 'ZINC' $ZINC | wc -l
grep -o '$$$$' $ZINC | wc -l

#!/bin/bash
#SBATCH --job-name=NAME
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=OUTPUT.log

# example of loading modules
# module load OpenBabel/2.3.2-foss-2016a-Python-2.7.11

HOMEDIR="/home/p275927/"
DATADIR="/data/p275927/"

# run code

#!/bin/bash
#SBATCH --job-name=sdf_split
#SBATCH --partition=short
#SBATCH --time=30:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=sdf_split.log

# custom wrapper for running python scripts

HOMEDIR="/home/p275927/"
DATADIR="/data/p275927/"

# run code
python split_sdf.py

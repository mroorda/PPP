#!/bin/bash
#SBATCH --job-name=NAME
#SBATCH --partition=vulture
#SBATCH --time=01:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4GB
#SBATCH --output=/home/p275927/PPP/outfiles/OUTPUT_%j.log

# example of loading modules
# module load OpenBabel/2.3.2-foss-2016a-Python-2.7.11

# define vars
HOMEDIR="/home/p275927/"
DATADIR="/data/p275927/"

# run code
echo $1

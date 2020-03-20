#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=vulture
#SBATCH --time=02:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB
#SBATCH --output=smina_slurm.log

# module load OpenBabel/2.3.2-foss-2016a-Python-2.7.11
# module load Boost/1.61.0-foss-2016a-Python-2.7.11

### run code

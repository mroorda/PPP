#!/bin/bash
#SBATCH --job-name=zinc15_download
#SBATCH --partition=regular
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --mem=16GB
#SBATCH --cpus-per-task=16
#SBATCH --output=zinc15_download_slurm-batch2.log

cd /data/p275927/ZINC15/
sh ZINC-downloader-3D-sdf.gz.wget


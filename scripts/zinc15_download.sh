#!/bin/bash
#SBATCH --job-name=zinc_dl
#SBATCH --partition=regular
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=2GB

### download database
cd /data/p275927/ZINC15/tranches_gz/
sh ZINC-downloader-3D-sdf.gz.wget

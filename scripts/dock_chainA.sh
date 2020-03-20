#!/bin/bash
#SBATCH --job-name=smina_dock
#SBATCH --partition=vulture
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1GB
#SBATCH --output=hgaaro.log

# module load OpenBabel/2.3.2-foss-2016a-Python-2.7.11
# module load Boost/1.61.0-foss-2016a-Python-2.7.11

### run docking
for i in ./ligands/*.sdf.gz
do
# retain the part of ligand name before the the period
NAME="${i##*/}"
NAME="${NAME%.*}"
echo $NAME
smina --receptor 4uuu_dimer_nosolvent_SAM-B.pdb --ligand $i --autobox_ligand SAM_crystal_chainA.sdf \
    --exhaustiveness 8 --num_modes 9 --cpu 4 --atom_term_data \
    --out "./results/$NAME.sdf" --log "./results/$NAME.txt"
done

### summarize result scores
rm ./results/scores.txt

touch ./results/scores

for i in ./results/*.txt
do
NAME="${i##*/}" # clean up ligand name as not to write the path and file extension to the results list
NAME="${NAME%.*}"
echo $NAME >> results/scores
sed -n 26p $i >> results/scores
done

mv ./results/scores ./results/scores.txt # make file readable by standard text editors

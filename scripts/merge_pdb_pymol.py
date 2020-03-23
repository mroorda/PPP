from pymol import cmd
import os

indir = '/data/p275927/USR-VS/ligand_sdf/'
outdir = '/data/p275927/USR-VS/ligand_pdb/'
rec_file = '/data/p275927/receptor/4uuu_dimer_nosolvent.pdb'

for filename in os.listdir(indir):
    if filename.endswith('.pdb'):
        print(filename)
        # load receptor pdb
        cmd.load(rec_file, 'receptor')
        # load ligand pdb
        cmd.load(indir + filename, 'ligand')
        # alter the atomic properties of ligand
        cmd.alter('ligand', 'chain = "A"')
        cmd.alter('ligand', 'segi = "C"')
        # join into one pdb
        cmd.copy_to('receptor', 'ligand')
        # cleanup
        cmd.delete('ligand')
        # save
        cmd.save(outdir + filename)
        # cleanup
        cmd.delete('receptor')

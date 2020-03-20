from pymol import cmd
import os

workdir = '/home/p275927/PPP/plip/'
pdbdir = '/home/p275927/PPP/plip/pdbs/'
os.chdir(workdir)

for filename in os.listdir(pdbdir):
    if filename.endswith('.pdb'):
        print(filename)
        # load receptor pdb
        cmd.load('4uuu_dimer_nosolvent.pdb', 'receptor')
        # load ligand pdb
        cmd.load(pdbdir + filename, 'ligand')
        # alter the atomic properties of ligand
        cmd.alter('ligand', 'chain = "A"')
        cmd.alter('ligand', 'segi = "C"')
        # join into one pdb
        cmd.copy_to('receptor', 'ligand')
        # cleanup
        cmd.delete('ligand')
        # save
        cmd.save(pdbdir + filename)
        # cleanup
        cmd.delete('receptor')

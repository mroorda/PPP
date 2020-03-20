from Bio.PDB.PDBParser import PDBParser
from Bio.PDB.PDBIO import PDBIO

parser = PDBParser(PERMISSIVE=1)

protein = parser.get_structure('protein', '4uuu_dimer_nosolvent.pdb')
ligand = parser.get_structure('ligand', 'hits-USR_compound1.pdb')
compound = ligand.header["compound"]

io = PDBIO()
io.set_structure(ligand)
io.save("out.pdb")

import os

def MakePDB(molecules):
    if ".sdf" in molecules:
        poses = list(readfile("sdf",molecules))
        pdbfilename = molecules.replace(".sdf",".pdb")
    elif ".pdb" in molecules:
        poses = list(readfile("pdb",molecules))
        pdbfilename = molecules.replace(".pdb","_fix.pdb")

    ### Normalize affinity data against Heavy Atom acount of corresponding drug. This gives a more comparable value to rank on. (Ligand efficiency). Write these values to a list, index corresponding to pose number
    HatomCount = poses[0].calcdesc()['atoms']
    if "sdf" in sysargs.input:
        affinitydata = [(float(pose.data["minimizedAffinity"]))/(HatomCount) if pose.data.has_key("minimizedAffinity") else 0 for pose in poses] ### grab affinity info for all conformers from SDF file and save it to list
    else:
        affinitydata = []
    atomcountdict = {}
    modelcounter = 1
    ### Rewrite PDB file to remove connect records and give each atom a unique name. This is necessary for Biopython to differentiate between them
    with open(pdbfilename,"w") as pdbfile:
        for pose in poses:
            pose.OBMol.AddPolarHydrogens()
            posestring = pose.write("pdb")
            pdbfile.write("MODEL " + str(modelcounter).rjust(8) + "\n")

            for line in posestring.splitlines():
                if ("pdb" in sysargs.input) and ("minimizedAffinity" in line):
                    affinitydata.append((float(line[25:]))/(HatomCount))
                if "HETATM" in line:
                    atomtype = line[13]

                    if atomtype in atomcountdict:
                        atomcountdict[atomtype] += 1

                    else:
                        atomcountdict[atomtype] = 1

                    unique_atom = str(atomcountdict[atomtype]).ljust(2)
                    conformer_name = "M" + str(modelcounter).ljust(2)
                    newline = line[0:14] + unique_atom + line[16:17] + conformer_name + line[20:] + "\n"
                    pdbfile.write(newline)

            pdbfile.write("ENDMDL\n")
            atomcountdict = {}
            modelcounter += 1

        pdbfile.write("END")
    return affinitydata,pdbfilename


os.chdir('/home/p275927/PPP/plip/USR-VS/')

for filename in os.listdir():
    print(filename)
    MakePDB(filename)

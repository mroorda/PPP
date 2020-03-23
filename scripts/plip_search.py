import os
from bs4 import BeautifulSoup as BS

# what this script should do
# iterate over files in folder (load/open)
# iterate over lines in files
# check each line for presence of two specific contacts
# if present, give score per each
# write name of molecule and score to csv output file
# move pymol session files of scored molecules to dedicated folder

# set up file locations
xml_files = "/data/p275927/USR-VS/contacts/"
dfile = xml_files + "4uuu_dimer_nosolvent_SAM-B" + ".pdb.xml"
print(dfile)

# read in xml file
with open(dfile) as fp:
    soup = BS(fp)

print(soup.get_text())



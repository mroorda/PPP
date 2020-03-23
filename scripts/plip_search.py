import os
import re
import csv

# this script searches the xml file output by plip for specific contacts
# scores are assigned per contact and output to csv
# to do:
# move pymol session files of scored molecules to dedicated folder

# define dictionary for searched contacts
contacts = { "pi_stack" : """<pi_stack id=".">
          <resnr>443</resnr>
          <restype>PHE</restype>
          <reschain>A</reschain>""",
            "salt_bridge_A" : """<salt_bridge id=".">
          <resnr>444</resnr>
          <restype>ASP</restype>
          <reschain>A</reschain>""",
            "salt_bridge_B" : """<salt_bridge id=".">
          <resnr>444</resnr>
          <restype>ASP</restype>
          <reschain>B</reschain>""",
            "h_bond_A" : """<hydrogen_bond id=".">
          <resnr>444</resnr>
          <restype>ASP</restype>
          <reschain>A</reschain>""",
            "h_bond_B" : """<hydrogen_bond id=".">
          <resnr>444</resnr>
          <restype>ASP</restype>
          <reschain>B</reschain>""" }

# set up file locations
# input directory
xml_dir = "/data/p275927/USR-VS/contacts/USRCAT/"
# output file
out_file = open("/data/p275927/USR-VS/plip_contacts_USRCAT.csv", "w")
header = ['pi_stack', 'salt_bridge_A', 'salt_bridge_B', 'h_bond_A', 'h_bond_B',
          'ZINC_ID', 'pose']
writer = csv.DictWriter(out_file, fieldnames = header)
writer.writeheader()

# loop through directory
for filename in os.listdir(xml_dir):
    if filename.endswith(".xml"):
        xml_file_path = os.path.join(xml_dir, filename)
        # read in xml file
        with open(xml_file_path, "r") as xml_file:
            soup = xml_file.read()
            # define scoring dictionary
            score = { "pi_stack" : 0,
                     "salt_bridge_A" : 0,
                     "salt_bridge_B" : 0,
                     "h_bond_A" : 0,
                     "h_bond_B" : 0 }
            # look for the searched contacts
            for i, j in contacts.items():
                print(i) # i is the name of contact
                if re.search(j, soup): # j is the xml string
                    print("found match")
                    score[i] = 1 # give a point for contact
                else:
                    print("no match")
            # obtain compound and pose ID
            fileIDs = re.split('_', filename)
            ID = fileIDs[1]
            pose = re.split('\.', fileIDs[2])[0]
            # add compound identifiers to score dictionary
            score['ZINC_ID'] = ID
            score['pose'] = pose
            # score['mean'] = sum(score.values())/len(score.values())
            print(score)
            # append compound ID and scores to csv file
            writer.writerow(score)
    else:
        print("Skipping non-xml.")

out_file.close()

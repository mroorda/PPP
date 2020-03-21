database = "/data/p275927/ZINC15/database/ZINC15"
nmol = 9218 # number of molecules in each file
step = nmol # setup step variable

# counter for number of molecules
i = 0
# counter for number of files
j = 0

chunkfile = open(database + '_' + str(j) + '.sdf', 'w')

# iterate over all lines of database file
for line in open(database + '.sdf'):
	chunkfile.write(line)
	if line[:4] == "$$$$":
		i+=1
	if i > step: # if already written a set amount of molecules, start a new file
		chunkfile.close()
		j+=1
		chunkfile = open(database + '_' + str(j) + '.sdf', 'w')
		step += nmol

print(chunkfile)

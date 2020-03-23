# PPP
Repo for the development of a virtual compound screen pipeline using the Peregrine cluster

## Introduction
Some text here

## Goals
- large scale virtual screening using ZINC15 compounds that are in stock (docking)
- docking of SWEETLEAD molecular library (registered compounds)
- 3D pattern ZINC15 query using USR-VS, docking
- pharmacophore model generation and query, docking
- process docked poses with plip
- filter docked poses based on specific contacts

## Software

- UN*X
- Python 3.8.x, 2.7.x
- Openbabel
- smina
- plip https://github.com/ssalentin/plip
- ranger
- vim



## Pipeline ZINC15 screen
- download database
- gunzip database (gives error for 44 files)
- consolidate database into single file
- break up database into even-sized chunks (flatten)

### Troubleshooting

Zinc15 database contained 9090020 compounds after unzipping and consolidation. The expected number was 9217262, which means there were 127242 compounds missing. This most likely happened during the unzip step which failed for 44 .sdf.gz files. These files were named *.xab.sdf.gz, compared to the successfully processed *.xaa.sdf.gz. The xa. part is created by naming by the linux function slice. Some of the missing 44 files were re-downloaded (n = 38), the rest were "not found" by the downloader script. It might be due to updates to the database, although when repeating exactly the same query parameters in tranches on the zinc15 website, the result was exactly the same amount of compounds. If the database update is the issue, it might be the organizing into different tranches. Therefore let's not worry about this for the moment, and instead first develop a pipeline which can be used to quickly download and process a fresh database right before docking.

#!/bin/bash

# a docking job was run for 4 hours at 4 cpu
# how many compounds did we manage to dock?

grep -o 'Refine' hgaaro.log | wc -l
grep -o '$$$$' ligands/HGAARO.xaa.sdf | wc -l

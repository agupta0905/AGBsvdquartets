This repository contains all scripts used in our paper,
A Comparative Study of SVDquartets and Other Coalescent-Based Species Tree Estimation Methods.

##Simulated Dataset Locations
The original, unprocessed simulated datsets used in this study were obtained from the following:
1) The 11-taxon datasets M1, M2, M3, and M4 with varying levels of ILS was obtained from

2) The 15-taxon dataset with a pectinate model species tree was obtained from 
http://www.cs.utexas.edu/users/phylo/datasets/weighted-binning-datasets.html
under the "15-taxon datasets" link.
3) The 37-taxon mammalian simulated dataset with AD=18% was obtained from
https://www.ideals.illinois.edu/handle/2142/55319
under the link "Sequence Alignments and Trees for Mammalian 2X for Mirarab et. al."

##Linux executables for the species tree estimation methods 
ASTRAL [1], NJst [2], FastTree [3], and RAxML [4] are in the phylogenetic_tools folder. 

The files in each "pipeline-" folder are a combination of shell scripts and qsub scripts 
for the UIUC campus cluster. 

0) pipeline-data_processing contains scripts to sample a portion of the shorten phylip alignments, 
1) pipeline-summary_methods 






1. 
2. 
3.
4.
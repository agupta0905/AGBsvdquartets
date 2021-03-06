This repository contains all scripts used in our paper,
A Comparative Study of SVDquartets and Other Coalescent-Based Species Tree Estimation Methods.

##Simulated Datasets
The original, unprocessed simulated datsets used in this study were obtained from the following:


1. The 11-taxon datasets M1, M2, M3, and M4 with varying levels of ILS was obtained from
http://www.cs.utexas.edu/~bayzid/files/10-taxon.tar.bz

2. The 15-taxon dataset with a pectinate model species tree was obtained from 
http://www.cs.utexas.edu/users/phylo/datasets/weighted-binning-datasets.html
under the "15-taxon datasets" link.

3. The 37-taxon mammalian simulated dataset with AD=18% was obtained from
https://www.ideals.illinois.edu/handle/2142/55319
under the link "Sequence Alignments and Trees for Mammalian 2X for Mirarab et. al."

##Linux Executables for Species Tree Estimation Methods
The linux executables for ASTRAL [1], NJst [2], FastTree [3], and RAxML [4] are in the phylogenetic_tools folder. 
The linux executable for PAUP* [5]  is in the src-pipelines folder. 

##Scripts for Running Species Tree Estimation Methods on the Simulated Datasets

The files in each "pipeline-" folder are a combination of shell scripts and qsub scripts 
for the UIUC campus cluster. 

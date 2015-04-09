##SVDquartets with QMC and WQMC

Pipeline to run SVDQuartet + QMC and SVDQuartet + wQMC on SNP data

##Running

To run on linux run the script "*run_pipeline.sh*" 

##Example usage: 
	./run_pipeline.sh data/model.10.200000.0.000001000/01 ~/scratch/AGBsvdquartets 100 1 C 0

#Prerequisites

    Make sure there is a folder ~/scratch/AGBsvdquartets/data which has the model folders etc. Also make sure there is taxa_dict.txt
    in your actual data folder (not the one in scratch). All the intermediate data is stored on scratch and only the relevant final output
    tree files are stored in the personal folder.

##Note
1. Number of quartets considered is chosen to be 330, can be changed in the file "*src-pipeline/calculate_svd_scores.paup*"

2. data folder contains only a sample of the 11-taxon dataset

3. Tested on Ubuntu 12.04

4. For running on mac use "*paup_mac*" inside the shell script

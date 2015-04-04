##SVDquartets with QMC and WQMC

Pipeline to run SVDQuartet + QMC and SVDQuartet + wQMC on SNP data

##Running

To run on linux run the script "*run_pipeline.sh*" 

##Example usage: 
	./run_pipeline.sh data/model.10.200000.0.000001000/01 25 

##Note
1. Number of quartets considered is chosen to be 50, can be changed in the file "*src-pipeline/calculate_svd_scores.paup*"

2. data folder contains only a sample of the 11-taxon dataset

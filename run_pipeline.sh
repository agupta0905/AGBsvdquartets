#!/bin/bash
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 input_speciestree_path n k WfnCode contiguousflag"
  exit 1
fi
SPECIES_PATH=$1
N=$2
K=$3
WCode=$4
Cflag=$5
if [  ! -d $SPECIES_PATH"/relabeled_data" ]; then
	echo "relabelling data at "$SPECIES_PATH
	python src-pipeline/taxon_relabeler.py $SPECIES_PATH data/taxa_dict.txt >log_taxon_relabeler.txt
fi
if [  ! -d $SPECIES_PATH"/relabeled_shortened_data_"$N ]; then
	if [  "$Cflag" == "0" ]; then
		echo "shortening data "$SPECIES_PATH" for non-continous for N="$N
		python src-pipeline/gene_length_shortener.py $SPECIES_PATH $N >log_gene_length_shortener.txt
	fi

	if [  "$Cflag" == "1" ]; then
		echo "shortening data "$SPECIES_PATH" for continous for N="$N
		python src-pipeline/gene_length_shortener.py $SPECIES_PATH $N -c >log_gene_length_shortener.txt
	fi
fi

echo "sampling genes for "$SPECIES_PATH" for N="$N" for k="$K
python src-pipeline/gene_sampler.py $SPECIES_PATH $N $K >log_gene_sampler.txt
echo "aggregating sampled genes for "$SPECIES_PATH" for N="$N" for k="$K	
python src-pipeline/gene_aggregator.py $SPECIES_PATH $N $K >log_gene_aggregator.txt
rm -f paup_quartet_trees.txt
cp $SPECIES_PATH"/relabeled_shortened_sampled_combined_"$N"_"$K".nex" input_data_for_paup.nex
echo "running SVDquartets"
./src-pipeline/paup_linux src-pipeline/calculate_svd_scores.paup >log_paup.txt
rm -f qmc_quartet_trees.txt
rm -f wqmc_quartet_trees.txt
echo "convert SVDquartet output to QMC and WQMC using WfCode "$WCode
python "src-pipeline/convert_svd_qmc_wqmc_"$WCode.py >log_convert_svd_qmc_wqmc_$WCode.txt
echo "running QMC"
./src-pipeline/max-cut-tree qrtt=qmc_quartet_trees.txt weights=off otre=$SPECIES_PATH"/svd_qmc_s_tree_"$N"_"$K"_"$WCode.trees >log_qmc.txt
echo "running wQMC"
./src-pipeline/max-cut-tree qrtt=wqmc_quartet_trees.txt weights=on otre=$SPECIES_PATH"/svd_wqmc_s_tree_"$N"_"$K"_"$WCode.trees >log_wqmc.txt
rm -f log.txt out.txt paup_quartet_trees.txt qmc_quartet_trees.txt wqmc_quartet_trees.txt input_data_for_paup.nex



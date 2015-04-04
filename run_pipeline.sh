#!/bin/bash
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input_speciestree_path k"
  exit 1
fi
SPECIES_PATH=$1
K=$2
python src-pipeline/taxon_relabeler_sampler.py $SPECIES_PATH data/taxa_dict.txt $K
python src-pipeline/gene_aggregator.py $SPECIES_PATH $K
rm -f paup_quartet_trees.txt
cp $SPECIES_PATH"/relabeled_sampled_combined_"$K".nex" input_data_for_paup.nex
./src-pipeline/paup_linux src-pipeline/calculate_svd_scores.paup
rm -f qmc_quartet_trees.txt
rm -f wqmc_quartet_trees.txt
python src-pipeline/convert_svd_qmc_wqmc.py
./src-pipeline/max-cut-tree qrtt=qmc_quartet_trees.txt weights=off otre=$SPECIES_PATH"/svd_qmc_s_tree_"$K".trees"
./src-pipeline/max-cut-tree qrtt=wqmc_quartet_trees.txt weights=on otre=$SPECIES_PATH"/svd_wqmc_s_tree_"$K".trees"
rm -f log.txt out.txt paup_quartet_trees.txt qmc_quartet_trees.txt wqmc_quartet_trees.txt input_data_for_paup.nex



#!/bin/bash
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 input_speciestree_path data_parent_folder_path n k WfnCode contiguousflag"
  exit 1
fi
SPECIES_PATH=$1
DATA_PARENT=$2
N=$3
K=$4
WCode=$5
Cflag=$6


if [  ! -d ${SPECIES_PATH} ]; then
	echo "CREATING DIRECTORY ${SPECIES_PATH}"
	mkdir -p ${SPECIES_PATH}
fi
if [  ! -d "${DATA_PARENT}/${SPECIES_PATH}/relabeled_data" ]; then
	echo "RELABELING DATA AT ${SPECIES_PATH}"
	python src-pipeline/taxon_relabeler.py "${DATA_PARENT}/${SPECIES_PATH}" data/taxa_dict.txt
	cp "${DATA_PARENT}/${SPECIES_PATH}/S_relabeled_tree.trees" "${SPECIES_PATH}/S_relabeled_tree.trees"
fi

if [  ! -d "${DATA_PARENT}/${SPECIES_PATH}/relabeled_shortened_data_${N}" ]; then
	if [  "${Cflag}" == "0" ]; then
		echo "SHORTENING DATA ${SPECIES_PATH} non-continously for N=${N}"
		python src-pipeline/gene_length_shortener.py "${DATA_PARENT}/${SPECIES_PATH}" ${N}
	fi

	if [  "${Cflag}" == "1" ]; then
		echo "SHORTENING DATA ${SPECIES_PATH} continously for N=${N}"
		python src-pipeline/gene_length_shortener.py "${DATA_PARENT}/${SPECIES_PATH}" ${N} -c
	fi
fi

if [  ! -d "${DATA_PARENT}/${SPECIES_PATH}/relabeled_shortened_sampled_data_${N}_${K}" ]; then
	echo "SAMPLING GENES FOR ${SPECIES_PATH} for N=${N} for k=${K}"
	python src-pipeline/gene_sampler.py "${DATA_PARENT}/${SPECIES_PATH}" ${N} ${K}
fi
if [  ! -e "${SPECIES_PATH}/relabeled_shortened_sampled_combined_${N}_${K}.nex" ]; then
	echo "AGGREGATING SAMPLED GENES FOR ${SPECIES_PATH} for N=${N} for k=${K}"
	python src-pipeline/gene_aggregator.py "${DATA_PARENT}/${SPECIES_PATH}" ${N} ${K}
	cp "${DATA_PARENT}/${SPECIES_PATH}/relabeled_shortened_sampled_combined_${N}_${K}.nex" "${SPECIES_PATH}/relabeled_shortened_sampled_combined_${N}_${K}.nex"
fi

if [  ! -e "${SPECIES_PATH}/paup_quartet_trees_${N}_${K}.txt" ]; then
	rm -f paup_quartet_trees.txt
	cp "${SPECIES_PATH}/relabeled_shortened_sampled_combined_${N}_${K}.nex" input_data_for_paup.nex
	echo "RUNNING SVDQUARTETS"
	./src-pipeline/paup_linux src-pipeline/calculate_svd_scores.paup
	cp paup_quartet_trees.txt "${SPECIES_PATH}/paup_quartet_trees_${N}_${K}.txt"

else 
	cp "${SPECIES_PATH}/paup_quartet_trees_${N}_${K}.txt" ./paup_quartet_trees.txt

fi

rm -f qmc_quartet_trees.txt
rm -f wqmc_quartet_trees.txt
echo "CONVERTING SVDQUARTET OUTPUT TO QMC/WQMC using WFCode ${WCode}"
python "src-pipeline/convert_svd_qmc_wqmc_${WCode}.py"
cp qmc_quartet_trees.txt "${SPECIES_PATH}/qmc_quartet_trees_${N}_${K}_${WCode}.txt"
cp wqmc_quartet_trees.txt "${SPECIES_PATH}/wqmc_quartet_trees_${N}_${K}_${WCode}.txt"
echo "RUNNING QMC"
./src-pipeline/max-cut-tree qrtt=qmc_quartet_trees.txt weights=off otre="${SPECIES_PATH}/svd_qmc_s_tree_${N}_${K}.trees"

echo "RUNNING wQMC"
./src-pipeline/max-cut-tree qrtt=wqmc_quartet_trees.txt weights=on otre="${SPECIES_PATH}/svd_wqmc_s_tree_${N}_${K}_${WCode}.trees"
rm -f log.txt out.txt paup_quartet_trees.txt qmc_quartet_trees.txt wqmc_quartet_trees.txt input_data_for_paup.nex



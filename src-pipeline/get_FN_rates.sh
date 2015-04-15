#!/bin/bash                                                                      

n=$1   
 
cd ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111
rm -f FN_rates_all_${n}_R_format
touch FN_rates_all_${n}_R_format

for k in 1 5 10 25; do
    rm -f temp_qmc_${n}_${k}
    touch temp_qmc_${n}_${k}
    rm -f FN_svd_qmc_${n}_${k}
    touch FN_svd_qmc_${n}_${k}
    for WCODE in A B C D E F G; do
	rm -f temp_wqmc_${n}_${k}_${WCODE}
	touch temp_wqmc_${n}_${k}_${WCODE}
	rm -f FN_svd_wqmc_${n}_${k}_${WCODE}
	touch FN_svd_wqmc_${n}_${k}_${WCODE}
    done
done
                  
for FOLDERNUMBER in {1..50}; do 
    cd ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/${FOLDERNUMBER}
    cp ~/SVD_experiments/AGBsvdquartets/tree_comp/CompareTree.pl .
    cp ~/SVD_experiments/AGBsvdquartets/tree_comp/MOTree.pm .
    cp ~/SVD_experiments/AGBsvdquartets/tree_comp/compareTrees .
    cp ~/SVD_experiments/AGBsvdquartets/tree_comp/compareTrees.missingBranch .
    for k in 1 5 10 25; do
	./compareTrees.missingBranch S_relabeled_tree.trees svd_qmc_s_tree_${n}_${k}.trees >> ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/temp_qmc_${n}_${k}
	
	for WCODE in A B C D E F G; do
	    if [  ! -e "svd_wqmc_s_tree_${n}_${k}_${WCODE}.trees" ]; then
		echo "no tree outputted for species ${FOLDERNUMBER} svd_wqmc_s_tree_${n}_${k}_${WCODE}.trees"
	    fi
	    ./compareTrees.missingBranch S_relabeled_tree.trees svd_wqmc_s_tree_${n}_${k}_${WCODE}.trees >> ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/temp_wqmc_${n}_${k}_${WCODE}
	done
    done
    rm CompareTree.pl
    rm MOTree.pm
    rm compareTrees*
done

cd ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/

for k in 1 5 10 25; do
    awk -vOFS=, '{ print $3 }' ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/temp_qmc_${n}_${k} | sed 's/,$/\n/' > FN_svd_qmc_${n}_${k}
    rm temp_qmc_${n}_${k}
    for WCODE in A B C D E F G; do
	awk -vOFS=, '{ print $3 }' ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/temp_wqmc_${n}_${k}_${WCODE} | sed 's/,$/\n/' > FN_svd_wqmc_${n}_${k}_${WCODE}
	rm temp_wqmc_${n}_${k}_${WCODE}
    done
done

for k in 1 5 10 25; do
    temp=$(cat ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/FN_svd_qmc_${n}_${k})
    echo "FN_svd_qmc_"${n}"_"${k}"=c("${temp}")" >> FN_rates_all_${n}_R_format
    for WCODE in A B C D E F G; do
	temp=$(cat ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/FN_svd_wqmc_${n}_${k}_${WCODE})
	echo "FN_svd_wqmc_"${n}"_"${k}"_"${WCODE}"=c("${temp}")" >> FN_rates_all_${n}_R_format
    done
done

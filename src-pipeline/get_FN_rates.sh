#!/bin/bash                                                                      

n=$1            
k=$2
WCODE=$3
 
cd ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/results_${n}_${k}
rm -f FN_svd_qmc_${n}_${k}
#rm -f FN_svd_wqmc_${n}_${k}_${WCODE}
touch FN_svd_qmc_${n}_${k}
#touch FN_svd_wqmc_${n}_${k}_${WCODE}
cd ~/SVD_experiments/AGBsvdquartets/
                  
for FOLDERNUMBER in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50; do 
    cd ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/${FOLDERNUMBER}
    cp ~/phylogenetic_tools/tree_comp/CompareTree.pl .
    cp ~/phylogenetic_tools/tree_comp/MOTree.pm .
    cp ~/phylogenetic_tools/tree_comp/compareTrees .
    cp ~/phylogenetic_tools/tree_comp/compareTrees.missingBranch .
    ./compareTrees.missingBranch S_relabeled_tree.trees svd_qmc_s_tree_${n}_${k}.trees >> ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/results_${n}_${k}/FN_svd_qmc_${n}_${k}
    #./compareTrees.missingBranch S_relabeled_tree.trees svd_wqmc_s_tree_${n}_${k}_${WCODE}.trees >> ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/results_${n}_${k}/FN_svd_wqmc_${n}_${k}_${WCODE}
    rm CompareTree.pl
    rm MOTree.pm
    rm compareTrees*
done

awk -vORS=, '{ print $3 }' ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/results_${n}_${k}/FN_svd_qmc_${n}_${k} | sed 's/,$/\n/'
#awk -vORS=, '{ print $3 }' ~/SVD_experiments/AGBsvdquartets/data/model.10.1800000.0.000000111/results_${n}_${k}/FN_svd_wqmc_${n}_${k}_${WCODE} | sed 's/,$/\n/'
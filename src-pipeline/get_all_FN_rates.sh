#!/bin/bash

#n=25,50, or 100
n=$1

cd ~/SVD_experiments/AGBsvdquartets/

for k in 1 5; do
    for WCODE in A B C D E F G; do
	./get_FN_rates.sh $n $k $WCODE
    done
done

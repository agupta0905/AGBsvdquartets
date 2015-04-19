#!/bin/bash
for t in $(seq 1 50)
do
	for n in 25 50 100
	do
		for k in 1 5 10 25
		do
			for wcode in A B C D E F G H I J K L
			do
				echo "running for species="$t" for n="$n" for k="$k" for wcode="$wcode
				./run_pipeline_cluster.sh data/model.10.5400000.0.000000037/$t scratch $n $k $wcode 0 > logs/output_$t"_"$n"_"$k"_"$wcode.txt
			done
		done
	done
done  


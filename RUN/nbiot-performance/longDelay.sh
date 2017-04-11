#!/bin/bash
#set -e

if [ ! -e "Executions" ]; then
	echo "You are in the wrong folder"
	exit 1
fi

nChilds=0
maxChilds=$(nproc)
nRuns=30

cellRadius="0.5" #500m
outFolder="longDelay"

nUeList="25 50 75 100 125 150 175 200"
#nUeList="25 75 125 200"
ulSchedulerList="pf mt rr"
scClusterSizeList="1 3 6 12"

for r in $(seq $nRuns); do
for nUe in $nUeList; do
for ulScheduler in $ulSchedulerList; do
echo $ulScheduler
for scClusterSize in $scClusterSizeList; do

	if [ $nChilds -lt $maxChilds ]; then
		nChilds=$(($nChilds+1))
	else
		wait
		nChilds=0
	fi

	outDir="Executions/$outFolder/clusterSizeComparation/ulScheduler=$ulScheduler/scClusterSize=$scClusterSize/nUe=$nUe/$r/"
	mkdir -p "$outDir"

	seed=$((RANDOM * RANDOM))
 	(time bin/LTE-Sim_NBIot SingleCellM2mUnderNbIotLongDelay $cellRadius $nUe $ulScheduler $scClusterSize $seed) > $outDir/traceLteSim.txt 2> $outDir/time.txt &
done
done
done
done
wait
nChilds=0
#./RUN/nbiot-performance/makeSuperNbIotGraphs.py "Executions/$outFolder/clusterSizeComparation"

#for scClusterSize in $scClusterSizeList; do
#echo "cluster size = $scClusterSize"
#for ulScheduler in $ulSchedulerList; do
#for nUe in $nUeList; do
#for r in $(seq $nRuns); do

#mkdir -p "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize/ulscheduler=$ulScheduler/nUe=$nUe/$r"
#ln -r --symbolic "Executions/$outFolder/clusterSizeComparation/ulScheduler=$ulScheduler/scClusterSize=$scClusterSize/nUe=$nUe/$r/traceLteSim.txt" "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize/ulscheduler=$ulScheduler/nUe=$nUe/$r"

##mkdir -p "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize/ulscheduler=$ulScheduler"
##cp -r "Executions/$outFolder/clusterSizeComparation/ulScheduler=$ulScheduler/scClusterSize=$scClusterSize/*" "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize/ulscheduler=$ulScheduler"

##./RUN/nbiot-performance/makeScenarioGraphs.py "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize/ulscheduler=$ulScheduler"
#done
#done
#done
#./RUN/nbiot-performance/makeNbIotComparationsGraphs.py "Executions/$outFolder/schedComparation/scClusterSize=$scClusterSize"
#done

cd "Executions"
tar cfz "$outFolder.tar.gz" "$outFolder"

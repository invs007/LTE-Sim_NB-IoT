#!/bin/bash

ruList="1 3 6 12"
schedulers="pf mt rr"
nUE=75
nRuns=15

for sched in $schedulers; do
for ru in $ruList; do
echo -n "$sched $ru "
for i in `seq $nRuns`; do
	echo -n "`./bin/lte-sim-r5 OnlyNbIot 0.5 $nUE $sched $ru $((RANDOM*RANDOM))|grep -i serv|cut -d\  -f2` "
done
echo

done
done

#!/bin/bash

N=${1:-10}
server='beaujolais.ucsf.edu'
server1='viz.msbioscreen.org'
server2='chablis.ucsf.edu'
SERVER=${2:-$server1}
echo "N = $N"
echo "server = $SERVER"

TOTAL=0
for i in $(seq 1 $N) #((i=0; i<$N; i++))
do 
RESI=$(curl -s -w "%{time_total} (%{http_code}) \n" -G --data-urlencode "s_KT=DiseaseDuration" -d "r_KT=15+22&s_Ys=ActualEDSS,MSSS&KT0=20&s_Vs=AgeAtExam,Gender&V0s=20+60,M"  --digest --user epic:EPIC $SERVER/CEAPI/getContext -o /dev/null)
echo $RESI
TOTALI=$(echo $RESI | cut -f 1 -d ' ')
TOTAL=$(echo "$TOTAL+$TOTALI" | bc)
done
MEAN=$(echo "$TOTAL*1000/$N" | bc)
echo "mean: $MEAN ms"

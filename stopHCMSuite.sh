#!/bin/bash
FILE=$1
while read line
do
  depl=$(echo $line | awk '{print $1}')
  repl=$(echo $line | awk '{print $2}')
  echo "Stopping deployment $depl (replicas=$repl)"
  kubectl scale --replicas=0 deployment/$depl -n hcm2
done < $FILE

kubectl delete -f /var/vols/itom/suite-install/hcm/output/hcm-kafka.yaml

#!/bin/bash
FILE=$1

# broker-0 (kafka) is not a deployment and does not scale, manual delete/create required
kubectl create -f /var/vols/itom/suite-install/hcm/output/hcm-kafka.yaml

# Scaling back all deployments
while read line
do
  depl=$(echo $line | awk '{print $1}')
  repl=$(echo $line | awk '{print $2}')
  echo "Starting deployment $depl (replicas=$repl)"
  kubectl scale --replicas=$repl deployment/$depl -n hcm2
done < $FILE


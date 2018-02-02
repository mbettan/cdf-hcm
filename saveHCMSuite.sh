#!/bin/bash
FILE=$1
echo "Saving current HCM deployment names and desired replicas"
kubectl get deployments -n hcm2 -o wide | tail -n +2 | awk '{print $1,$2}' > $FILE


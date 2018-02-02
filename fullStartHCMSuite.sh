#!/bin/bash
read -p "Are you sure you want to proceed to full shutdown ?" yn

# Start All master nodes
echo "Starting k8s services from all master nodes..."
#"$K8S_HOME/bin/kube-start.sh"
#sleep 30
"$K8S_HOME/bin/kube-status.sh"
watch kubectl get pods --all-namespaces
echo

# Start All workers nodes
echo "Starting k8s services from all workers nodes..."
COUNTER=1
while [  $COUNTER -lt 5 ]; do
	echo "Worker $COUNTER : go4sapnode$COUNTER"
	ssh root@go4sapnode$COUNTER "$K8S_HOME/bin/kube-start.sh"
	let COUNTER=COUNTER+1
done
echo

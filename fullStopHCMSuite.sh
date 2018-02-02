#!/bin/bash
read -p "Are you sure you want to proceed to full shutdown ?" yn

# Saving the configuration
echo "Saving the configuration"
rm -Rf config
./saveHCMSuite.sh config
echo
./saveHCMSuite.sh config
echo

# Stop All workers nodes
echo "Stopping k8s services from all workers nodes..."
COUNTER=1
while [  $COUNTER -lt 5 ]; do
	echo "Worker $COUNTER : go4sapnode$COUNTER"
	ssh root@go4sapnode$COUNTER "$K8S_HOME/bin/kube-stop.sh"
	let COUNTER=COUNTER+1
done
echo

# Stop All master nodes
echo "Stopping k8s services from all master nodes..."
$K8S_HOME/bin/kube-stop.sh
echo

# Shutdown All workers nodes
echo "Shutdown all workers nodes..."
COUNTER=1
while [  $COUNTER -lt 5 ]; do
        echo "Worker $COUNTER : go4sapnode$COUNTER"
        ssh root@go4sapnode$COUNTER "shutdown -h now"
        let COUNTER=COUNTER+1
done
echo

# Shutdown All master nodes
echo "Shutdown all master nodes..."
shutdown -h now
echo


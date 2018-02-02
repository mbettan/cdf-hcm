# HCM Suite - Restart Procedure

Update the script to change from hcm2 namespace to hcm1 namespace
Update the worker and master hostnames

./fullStopHCMSuite.sh

./fullStartHCMSuite.sh


Tips:


Shutdown master using kube-stop.sh
Shutdown each worker node using kube-stop.sh

Once all shutdown, on each server, check running process, what I have seen recently after Kube and docker stopped, some process is still hanging around, especially PostgreSQL, when this happens, best to reboot the box, do it in the order of Master first, and as soon as the master comes back online, login, and run kube-stop.sh, follow by iptables –F, kube-start.sh

Wait for master node start, once it is started, go reboot each worker node, login, kube-stop.sh, iptables –F, and try to startup all worker node around the same time with kube-start.sh.

You might end you with one or two nodes that gets all of the pods, you will have to go and manually kill some to re-disturb the pod.

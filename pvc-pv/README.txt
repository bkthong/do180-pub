Demo sequence:

$ oc create -f pvc.yaml
$ oc get pvc
	--> pvc pending as the default storage class not used
            and no static pvs
	--> oc describe pvc mypvc

	  "Normal  FailedBinding  1s (x2 over 4s)  persistentvolume-controller  no persistent volumes available for this claim and no storage class is set"

$ oc delete pvc --all

$ oc create -f pvc-dynamic.yaml
	--> dynamic provisioner of the default storage class used
$ oc get pvc
	--> pvc bound to dynamic pv
        --> Not neccessarily as the storageclass may "waitforconsumer" first
	--> oc describe pvc mypvc 

"Normal  WaitForFirstConsumer  3s    persistentvolume-controller  waiting for first consumer to be created before binding"

$ oc get pv
$ oc delete pvc --all
----------------------------------------------------------------------
$ oc create -f mysql-deploy.yaml
$ oc get pods
$ ./apply-pvc.sh  
	--> pvc created and bound to the dynamic pv
$ oc edit deploy mysql
   --> show volumeMount and volume declarations

$ oc rsh MYSQLPOD
	--> df -h
		--> shows the nfs file share mounted to /var/lib/mysql/data

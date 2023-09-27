DEMO Sequence Stateful
======================
Ensure you have a proper current project

$ oc create -f stateful-webserver.yaml
$ oc get statefulset
$ oc get pods
$ oc get pvc

$ oc rsh POD-0
	--> echo main >> /var/www/html/index.html
	--> curl localhost:8080
$ oc rsh POD-1
	--> curl localhost:8080	-- NOT same storage
	--> echo secondary >> /var/www/html/index.html
	--> curl localhost:8080

Terminal 1
==========
$ oc port-forward POD-0 8080:8080

Terminal 2
==========
$ oc port-forward POD-1 8081:8080
Terminal 3

$ curl localhosst:8080 --> main
$ curl localhosst:8081 --> secondary


IF TIME PERMITS: Compare to deployment method:

$ oc create -f deploy-webserver.yaml
$ oc create -f pvc.yaml
$ oc get deploy,pod,pvc
... then similar sequence above, except that
    when one pod is updated you see the changes in 
    the other pod

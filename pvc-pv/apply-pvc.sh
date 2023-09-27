oc set volumes deployment/mysql --add -t pvc -m /var/lib/mysql/data --name myvol --claim-name myclaim --claim-mode rwo --claim-size=1Gi 

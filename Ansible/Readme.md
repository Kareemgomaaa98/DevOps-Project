1. Run "chmod 400 TFkey" On The terminal Change permission of the key file using command

2. Run : "ansible-playbook -i inventory.txt <file>.yml -u ubuntu --key-file TFkey" to run the ansible code

3. To ssh to any instance  : "sudo ssh -i TFkey ubuntu@<ip>"

4. To access to any instance "http://<ip>:<port>"
__________________________________________________________________
Sonar Qube :

Installation Documentation :
https://github.com/jae1choi/sonaqueue-installation-guide
SonarQube runs on port 9000.

Log in with username: "admin" and password: "admin". SonarQube will prompt you to change your password.
__________________________________________________________________
Jenkins :

Installation Documentation :
https://www.jenkins.io/doc/book/installing/linux/
Jenkins runs on port 8080.

extensions :

SonarQube installation and Documintation with jenkins :
https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/jenkins-extension-sonarqube/

AWS :
https://plugins.jenkins.io/aws-credentials/  # Adds new credentials type to jenkins called AWS Credentials to save Access Keys

jdk versions:
https://jdk.java.net/archive/
__________________________________________________________________
Nexus : 

Installation Documentation : 
https://devopscube.com/how-to-install-latest-sonatype-nexus-3-on-linux/
Nexus runs on port 8081 or 8443 with https.
__________________________________________________________________

always oppen port 5000 !
__________________________________________________________________
ArgoCD :

Installation Documentation :
https://argo-cd.readthedocs.io/en/stable/getting_started/#1-install-argo-cd
SonarQube runs on port 443 before forward and 8080 after forward.

To loginto the ArgoCD GUI :
http:<clusterip>:8080

Log in with username: "admin" and to get password : 
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
echo <password> | base64 --decode  * Just copy the steing before the percent mark
__________________________________________________________________
helm : 

Installation Documentation :
https://devopscube.com/install-configure-helm-kubernetes/
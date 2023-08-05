1. Run "chmod 400 TFkey" On The terminal Change permission of the key file using command

2. Run : "ansible-playbook -i inventory.txt <file>.yml -u ubuntu --key-file TFkey" to run the ansible code

3. To ssh to any instance  : "sudo ssh -i TFkey ubuntu@<ip>"

4. To access to any instance "http://<ip>:<port>"
__________________________________________________________________
Sonar Qube :
https://github.com/jae1choi/sonaqueue-installation-guide
SonarQube runs on port 9000.
__________________________________________________________________
Jenkins :
https://www.jenkins.io/doc/book/installing/linux/
SonarQube runs on port 8080.
__________________________________________________________________
Nexus : 
https://devopscube.com/how-to-install-latest-sonatype-nexus-3-on-linux/
Nexus runs on port 8081 or 8443 with https.
__________________________________________________________________
always oppen port 5000 !
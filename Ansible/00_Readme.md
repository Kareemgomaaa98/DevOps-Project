1. Run this command "chmod 400 TFkey" On The terminal Change permission of the key file using command.

2. You can ssh to the ec2 using the following command :"sudo ssh -i TFkey ubuntu@34.230.38.106"

3. Run "ansible-playbook -i inventory.txt <file name>.yml -u ubuntu --key-file TFkey" to run the ansible code.

4. You can verify that Jenkins is running by accessing it via a web browser and navigating to http://jen_ec2_ip:8080.

- SonarQube documintaion link : https://github.com/jae1choi/sonaqueue-installation-guide
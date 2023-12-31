import subprocess
#python3 automate.py | tee >(ts '%Y-%m-%d %H:%M:%S' >> project.log)
def main():
    print("\n$$ Welcome to my CI/CD Project $$\n--- Please choose what to do ?")
    user = input("1- terraform apply\n2- terraform destroy\n3- ansible\n4- Link me to my cluster\n5- ArgoCD\n9- exit\nEnter choice:")

    if user == "1" or user == "terraform apply":
        terraform_apply()
        ansible()
        main()

    elif user == "2" or user == "terraform destroy":
        terraform_destroy()
        main()

    elif user == "3" or user == "ansible":
        ansible()
        main()

    elif user == "4" or user == "Configre kubectl":
        kube()
        main()

    elif user == "5" or user == "ArgoCD":
        kube()
        ArgoCD()
        main()

    elif user == "9" or user == "exit":
        exit()

    else:
        print("Please enter a correct choice")
        main()

tf_files = "/home/kareem/Projects/Devops_Project/main/Terraform"
ansible_files = "/home/kareem/Projects/Devops_Project/main/Ansible"

def terraform_apply():
    print("\n Terraform starts now :) \n")
    subprocess.run(["terraform", "apply", "--var-file=values.tfvars", "-auto-approve"], cwd=tf_files)

def terraform_destroy():
    print("\n Terraform destroys now :( \n")  
    subprocess.run(["terraform", "destroy", "--var-file=values.tfvars", "-auto-approve"], cwd=tf_files)
    subprocess.run(["rm", "inventory.txt", "TFkey",], cwd=ansible_files) #Remove old inventory and key pair files
    
def ansible():
    print("\n Ansible starts now :) \n \n Ansible takes 2 or 3 minutes \n Please wait ... ")
    subprocess.run(["chmod", "400", "TFkey"], cwd=ansible_files)  # Set the key pair file permission to read only
    commands = [
        ["ansible-playbook", "-i", "inventory.txt", "jenkins_instance.yml", "-u", "ubuntu", "--key-file", "TFkey"] ,
        ["ansible-playbook", "-i", "inventory.txt", "sonarqube_instance.yml", "-u", "ubuntu", "--key-file", "TFkey"],
        ["ansible-playbook", "-i", "inventory.txt", "nexus_instance.yml", "-u", "ubuntu", "--key-file", "TFkey" ]
    ]

    # Create a list of terminal commands to run each command in a new terminal window
    terminal_commands = []
    for command in commands:
        terminal_commands.append(f"gnome-terminal --tab -- bash -c \"cd {ansible_files} && {' '.join(command)}; exec bash\"")

    # Run each command in a new tab in the terminal window
    for terminal_command in terminal_commands:
        subprocess.Popen(terminal_command, shell=True)

def kube():
    print("\n Linking to k8s :) \n ")  
    subprocess.run(["aws", "eks" , "--region", "us-east-1" , "update-kubeconfig" , "--name" , "kareem-cluster"])
    print("\n Done ;) \n ")

def ArgoCD():
    print("\n Run cd pipe line firist to install ArgoCD \n ")  
    subprocess.run(["kubectl", "port-forward" , "svc/argocd-server", "-n" , "argocd" , "8090:443" ])
    print("\n open: http:localhost:8090 \n ")

main()
output "jenkins_instance_ip" {
  value       = aws_instance.Jenkins.public_ip
  description = "Jenkins public ip"
}

output "sonar_instance_ip" {
  value       = aws_instance.Sonar.public_ip
  description = "sonar public ip"
}

output "nexus_instance_ip" {
  value       = aws_instance.nexus.public_ip
  description = "nexus public ip"
}

# output "endpoint" {
#   value = aws_eks_cluster.MY_EKS.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.MY_EKS.certificate_authority[0].data
# }

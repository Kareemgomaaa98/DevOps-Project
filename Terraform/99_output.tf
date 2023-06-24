output "public1_id" {
    value=aws_subnet.pub_1.id
}

output "public2_id" {
    value=aws_subnet.pub_2.id
}
output "security_group_id" {
  value = aws_security_group.ec2_sg.id
}

# output "endpoint" {
#   value = aws_eks_cluster.MY_EKS.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.MY_EKS.certificate_authority[0].data
# }

resource "aws_eks_cluster" "my_eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.my_eks_cluster_role.arn
  
  vpc_config {
    subnet_ids = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.my_eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.my_eks_vpc_resource_controller_attachment,
  ]
  
  # Enable Control Plane Logging for API and audit logs
  enabled_cluster_log_types = ["api", "audit"]
}

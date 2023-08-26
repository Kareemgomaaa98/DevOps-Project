resource "aws_eks_node_group" "group1" {
  cluster_name    = aws_eks_cluster.my_eks_cluster.name
  node_group_name = "group1"
  node_role_arn   = aws_iam_role.my_eks_cluster_nodes_role.arn
  subnet_ids      = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  
# Number of worker nodes
  scaling_config { 
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # remote_access {
  #  ec2_ssh_key = var.key_pair_file
  # } 

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.my_eks_Worker_Node_Policy,
    aws_iam_role_policy_attachment.my_eks_CNI_Policy,
    aws_iam_role_policy_attachment.my_EC2_Container_Registry_ReadOnly,
  ]
}
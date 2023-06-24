# resource "aws_eks_node_group" "group1" {
#   cluster_name    = aws_eks_cluster.MY_EKS.name
#   node_group_name = "group1"
#   node_role_arn   = aws_iam_role.demo.arn
#   subnet_ids      = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.demo-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.demo-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.demo-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }
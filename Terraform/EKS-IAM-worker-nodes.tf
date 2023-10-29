resource "aws_iam_role" "my_workers" {
  name = "my_workers"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Attach AWS policies to IAM role for EKS Nodes
resource "aws_iam_role_policy_attachment" "my_eks_cluster_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my_workers.name
}
# Allow the Container Network Interface (CNI) plugin for EKS
resource "aws_iam_role_policy_attachment" "my_eks_CNI_Policy" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.my_workers.name
}

resource "aws_iam_role_policy_attachment" "my_eks_ECR" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_workers.name
}

 resource "aws_iam_role_policy_attachment" "my_eks_ImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.my_workers.name
 }
 
# # Grant permissions required by worker nodes in an EKS cluster
# resource "aws_iam_role_policy_attachment" "my_eks_Worker_Node_Policy" { 
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.my_eks_cluster_role.name
# }

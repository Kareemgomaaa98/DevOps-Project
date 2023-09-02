# Create an IAM role for the EKS cluster
resource "aws_iam_role" "my_eks_cluster_role" {
  name               = "my_eks_cluster_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Create an IAM policy document for assuming the EKS role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Attach AWS policies to IAM role using the "aws_iam_role_policy_attachment" resource. These policies are:

# Provide permissions to manage EKS clusters.
resource "aws_iam_role_policy_attachment" "my_eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.my_eks_cluster_role.name
}

# Provide read-only access to the Amazon Elastic Container Registry (ECR).
resource "aws_iam_role_policy_attachment" "my_EC2_Container_Registry_ReadOnly" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_eks_cluster_role.name
}

# Grant access to manage VPC resources for EKS clusters.
resource "aws_iam_role_policy_attachment" "my_eks_vpc_resource_controller_attachment" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.my_eks_cluster_role.name
}

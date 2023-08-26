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

# Create an IAM role for the EKS cluster
resource "aws_iam_role" "my_eks_cluster_role" {
  name               = "my_eks_cluster_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach AWS policies to IAM role using the "aws_iam_role_policy_attachment" resource. These policies are:

# Provide permissions to manage EKS clusters.
resource "aws_iam_role_policy_attachment" "my_eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.my_eks_cluster_role.name
}

# Grant access to manage VPC resources for EKS clusters.
resource "aws_iam_role_policy_attachment" "my_eks_vpc_resource_controller_attachment" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.my_eks_cluster_role.name
}

# Grant permissions required by worker nodes in an EKS cluster
resource "aws_iam_role_policy_attachment" "my_eks_Worker_Node_Policy" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my_eks_cluster_role.name
}
# Allow the Container Network Interface (CNI) plugin for EKS
resource "aws_iam_role_policy_attachment" "my_eks_CNI_Policy" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.my_eks_cluster_role.name
}
# Provide read-only access to the Amazon Elastic Container Registry (ECR).
resource "aws_iam_role_policy_attachment" "my_EC2_Container_Registry_ReadOnly" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_eks_cluster_role.name
}



# Create an IAM role for the EKS Nodes
resource "aws_iam_role" "my_eks_cluster_nodes_role" {
  name = "my_eks_cluster_nodes_role"

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
resource "aws_iam_role_policy_attachment" "my_eks_cluster_nodes_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my_eks_cluster_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "my_eks_cluster_nodes_ecr_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_eks_cluster_nodes_role.name
}

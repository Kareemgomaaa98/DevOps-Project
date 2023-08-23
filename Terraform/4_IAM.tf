resource "aws_iam_role" "demo" {
  name               = "eks-cluster-demo"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# Allowing the EKS service to assume the IAM role
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

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" { #Provides permissions to manage EKS clusters.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSVPCResourceController" { #Grants access to manage VPC resources for EKS clusters.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSWorkerNodePolicy" { #Grants permissions required by worker nodes in an EKS cluster.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKS_CNI_Policy" { #Allows the Container Network Interface (CNI) plugin for EKS.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEC2ContainerRegistryReadOnly" { #Provides read-only access to the Amazon Elastic Container Registry (ECR).
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.demo.name
}
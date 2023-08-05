# # Must create IAM role for EKS
# # Create our EKS
# resource "aws_eks_cluster" "MY_EKS" {
#   name     = "MY_EKS"
#   role_arn = aws_iam_role.demo.arn

#   vpc_config {
#     subnet_ids = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.demo-AmazonEKSVPCResourceController,
#   ]
# }

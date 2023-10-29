# Create a Launch Template for your worker nodes
resource "aws_launch_template" "my_launch_template" {
  name_prefix   = "my-launch-template"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = "my-key-pair"  # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30  # Adjust the size as needed
    }
  }
  tags = {
    Name = "my-launch-template"
  }
}

# Create a Security Group for your worker nodes
resource "aws_security_group" "my_security_group" {
  name_prefix   = "my-security-group"
  description   = "Security group for EKS worker nodes"
  vpc_id        = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-security-group"
  }
}

# Create an Auto Scaling Group for your EKS worker nodes
resource "aws_autoscaling_group" "eks_node_group" {
  name                      = "my-eks-worker-nodes"
  max_size                  = 5
  min_size                  = 1
  desired_capacity          = 3
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [aws_subnet.pub_1.id, aws_subnet.pub_2.id]
}

resource "aws_instance" "Jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.TF_Key.key_name            # Adding key pair

  tags = {
    Name = "Jenkins"
  }

  provisioner "local-exec" {
    command = "echo '[jen_ec2_ip]' >> public_ips.txt && echo ${self.public_ip} >> public_ips.txt && echo '' >> public_ips.txt"
  }
}

resource "aws_instance" "nexus" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.TF_Key.key_name            # Adding key pair

  tags = {
    Name = "Nexus"
  }

  provisioner "local-exec" {
    command = "echo '[nex_ec2_ip]' >> public_ips.txt && echo ${self.public_ip} >> public_ips.txt && echo '' >> public_ips.txt"
  }
}

resource "aws_instance" "Sonar" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.TF_Key.key_name            # Adding key pair

  tags = {
    Name = "Sonar"
  }

  provisioner "local-exec" {
    command = "echo '[son_ec2_ip]' >> public_ips.txt && echo ${self.public_ip} >> public_ips.txt && echo '' >> public_ips.txt"
  }
}

# Use a local-exec provisioner on the null_resource to concatenate the public_ips.txt files
resource "null_resource" "concatenate_public_ips" {
  provisioner "local-exec" {
    command = "cat public_ips.txt >> inventory.txt && rm public_ips.txt"
  }

  depends_on = [
    aws_instance.Jenkins,
    aws_instance.nexus,
    aws_instance.Sonar,
  ]
}

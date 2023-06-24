#Create Key pair to connect using ssh
#Public key will be stored in aws managment consoule in key pairs secion
resource "aws_key_pair" "TF_Key" {
  key_name   = "TF_Key"
  public_key = tls_private_key.rsa.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#Private key will be stored in your machine under the name of TFkey
resource "local_file" "TF_Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "TFkey"
}

resource "aws_subnet" "pub_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public1_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.avilabilty_zone1

  tags = {
    Name = "pub_1"
  }
}

resource "aws_subnet" "pub_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public2_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.avilabilty_zone2

  tags = {
    Name = "pub_2"
  }
}
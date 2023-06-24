#region
region = "us-east-1"

# vpc
vpc_cidr = "10.0.0.0/16"

# subnet
public1_subnet_cidr = "10.0.0.0/24"
public2_subnet_cidr = "10.0.1.0/24"
avilabilty_zone1 = "us-east-1a"
avilabilty_zone2 = "us-east-1b"

# ec2
ami = "ami-053b0d53c279acc90"
instance_type = "t2.medium"

# key_pair
key_pair_file = "../../AWS_keys/public.txt"
# Region
variable region{
    type=string
}

# vpc
variable vpc_cidr {
    type=string
}

# Subnet
variable public1_subnet_cidr {
    type=string
}

variable public2_subnet_cidr {
    type=string
}

# Avilabilty_zones
variable avilabilty_zone1 {
    type=string
}

variable avilabilty_zone2 {
    type=string
}

# ec2
variable ami {
    type=string
}

variable instance_type {
    type=string
}

# key_pair
variable key_pair_file {
    type=string
}
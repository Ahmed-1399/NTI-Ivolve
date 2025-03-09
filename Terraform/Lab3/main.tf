resource "aws_vpc" "ivolve_vpc" {
  cidr_block           = var.cidr[0]
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = var.resource_name[0]
  }
}

# IGW
resource "aws_internet_gateway" "ivolve_IGW" {
  vpc_id = aws_vpc.ivolve_vpc.id
  tags = {
    "Name" = var.resource_name[1]
  }
}

#####################[ EIP, NAT Gateway ]#####################

# EIP
resource "aws_eip" "ivolve_nat_eip" {
  domain = "vpc"
  tags = {
    "Name" = var.resource_name[4]
  }
}
# NAT Gateway
resource "aws_nat_gateway" "ivolve_nat" {
  allocation_id = aws_eip.ivolve_nat_eip.id
  subnet_id     = aws_subnet.ivolve_public_subnet.id
}
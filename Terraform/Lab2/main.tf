resource "aws_vpc" "ivolve_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true
  tags = {
    "Name" = "ivolve-VPC"
  }
}

# IGW
resource "aws_internet_gateway" "ivolve_IGW" {
  vpc_id = aws_vpc.ivolve_vpc.id
  tags = {
    "Name" = "ivolve-IGW"
  }
}


#####################[ Public Subnet ]#####################

# Public Subnet
resource "aws_subnet" "ivolve_public_subnet" {
  vpc_id                  = aws_vpc.ivolve_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.AZs
  tags = {
    "Name" = "ivolve-public-subnet"
  }
}
# Route Table for Public Subnet
resource "aws_route_table" "ivolve_public_RT" {
  vpc_id = aws_vpc.ivolve_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ivolve_IGW.id
  }
  tags = {
    "Name" = "ivolve-public-RT"
  }
}
# Subnet association for Public Subnet
resource "aws_route_table_association" "ivolve_RT_association" {
  subnet_id      = aws_subnet.ivolve_public_subnet.id
  route_table_id = aws_route_table.ivolve_public_RT.id
}

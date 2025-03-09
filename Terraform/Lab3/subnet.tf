
#####################[ Public Subnet ]#####################
resource "aws_subnet" "ivolve_public_subnet" {
  vpc_id                  = aws_vpc.ivolve_vpc.id
  cidr_block              = var.subnets["Public"].cidr_block
  availability_zone       = var.subnets["Public"].az
  depends_on              = [aws_internet_gateway.ivolve_IGW]
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_name[2]
  }
}
# Route Table for Public Subnet
resource "aws_route_table" "ivolve_public_RT" {
  vpc_id = aws_vpc.ivolve_vpc.id
  route {
    cidr_block = var.cidr[1]
    gateway_id = aws_internet_gateway.ivolve_IGW.id
  }
  tags = {
    "Name" = var.resource_name[3]
  }
}
# Subnet association for Public Subnet
resource "aws_route_table_association" "ivolve_public_RT_association" {
  subnet_id      = aws_subnet.ivolve_public_subnet.id
  route_table_id = aws_route_table.ivolve_public_RT.id
}

#####################[ Private Subnet ]#####################
resource "aws_subnet" "ivolve_private_subnet" {
  vpc_id                  = aws_vpc.ivolve_vpc.id
  cidr_block              = var.subnets["Private"].cidr_block
  availability_zone       = var.subnets["Private"].az
  map_public_ip_on_launch = false
  depends_on              = [aws_eip.ivolve_nat_eip]
  tags = {
    Name = var.resource_name[6]
  }
}
# Route Table for private Subnet
resource "aws_route_table" "ivolve_private_RT" {
  vpc_id = aws_vpc.ivolve_vpc.id
  route {
    cidr_block = var.cidr[2]
    gateway_id = aws_nat_gateway.ivolve_nat.id
  }
  tags = {
    "Name" = var.resource_name[7]
  }
}
# Subnet association for private Subnet
resource "aws_route_table_association" "ivolve_private_RT_association" {
  subnet_id      = aws_subnet.ivolve_private_subnet.id
  route_table_id = aws_route_table.ivolve_private_RT.id
}
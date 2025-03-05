resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

}

#####################[ RDS Subnet Group ]#####################

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = [aws_subnet.ivolve_private_subnet.id, aws_subnet.ivolve_private_subnet_2.id]

  tags = {
    Name = "RDS-Subnet-Group"
  }
}
#####################[ Security group for RDS ]#####################

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.ivolve_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RDS_sg"
  }
}
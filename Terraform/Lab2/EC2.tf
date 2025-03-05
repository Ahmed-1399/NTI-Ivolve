resource "aws_instance" "ivolve_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ivolve_public_subnet.id
  key_name               = var.private_key
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y nginx
  systemctl enable --now nginx
  echo "Ivolve Lab 2 from $(hostname -f)" > /usr/share/nginx/html/index.html
  systemctl restart nginx
  EOF
  
  lifecycle {
    # Terraform [creates a new EC2 instance]...before [destroys the old instance].
    create_before_destroy = true
  }
}

#####################[ Security group for EC2 instance ]#####################

resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2_sg"
  vpc_id      = aws_vpc.ivolve_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "EC2_sg"
  }
}

#####################[ Key-Pair for EC2 instance ]#####################

resource "tls_private_key" "my-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "my-key" {
  key_name   = var.private_key
  public_key = tls_private_key.my-key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.my-key.private_key_pem}' > my-key.pem"
    # to Download "private_key" to my pc
    interpreter = ["PowerShell", "-Command"]
  }
}
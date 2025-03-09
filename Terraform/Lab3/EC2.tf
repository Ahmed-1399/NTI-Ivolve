#####################[ Public Instance ]#####################

resource "aws_instance" "ivolve_public_sub_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.ivolve_public_subnet.id
  key_name      = var.key_name
  #  Associate {public EC2 instance} with a {security group}
  vpc_security_group_ids      = [aws_security_group.dynamic_sg["sg_public_ec2"].id]
  associate_public_ip_address = true
  # to ensure Private_Instance_ Operate & Private_Key Downloaded
  depends_on = [aws_instance.ivolve_Private_sub_ec2]

  tags = {
    Name = var.instance_name[0]
  }
  # Change Permission of Private_Key
  provisioner "local-exec" {
    command = "chmod 400 mykey.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl enable --now nginx",
      "sudo mkdir -p /usr/share/nginx/html",
      "echo 'Public Instance Nginx' | sudo tee /usr/share/nginx/html/index.html",
      "sudo systemctl restart nginx"
    ]
    # Specify How {remote-exec} connect with EC2
    connection {
      type        = "ssh"
      user        = "ec2-user"
                            # Display Path Auto
      private_key = file("${path.module}/${var.private_key}")
      host        = self.public_ip
    }
  }
  # May face some Problems such as Instance still launch
  # Delay to get of Public_IP
  timeouts {
    create = "2m"
  }
}

#####################[ Private Instance ]#####################
resource "aws_instance" "ivolve_Private_sub_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.ivolve_private_subnet.id
  key_name      = var.key_name
  #  Associate {Private EC2 instance} with a {security group}
  vpc_security_group_ids      = [aws_security_group.dynamic_sg["sg_private_ec2"].id]
  associate_public_ip_address = false
  tags = {
    Name = var.instance_name[1]
  }
  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install httpd -y
  systemctl enable --now httpd
  echo "Private Instance Apache" > /var/www/html/index.html
  systemctl restart httpd
  EOF
}

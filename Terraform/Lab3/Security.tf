#####################[ Key-Pair ]#####################

resource "tls_private_key" "my-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "my-key" {
  key_name   = var.key_name
  public_key = tls_private_key.my-key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.my-key.private_key_pem}' > mykey.pem"
    # to Download "private_key" to my pc-Windows
    interpreter = ["PowerShell", "-Command"]
  }
}


#####################[ SG for Public, Private Instance ]#####################
resource "aws_security_group" "dynamic_sg" {
  for_each    = { for sg in var.security_groups : sg.name => sg }
  name        = each.value.name
  description = each.value.description
  # Refer to VPC Dynamically
  vpc_id = aws_vpc.ivolve_vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
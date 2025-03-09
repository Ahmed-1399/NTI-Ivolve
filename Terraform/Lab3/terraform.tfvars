region = "us-east-1"


#####################[VPC]#####################

#           VPC         Public_RT    Private_RT 
cidr = ["10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0"]
resource_name = ["ivolve-VPC", "ivolve-IGW", "ivolve-public-subnet", "ivolve-public-RT", "EIP_Address", "NAT_gateway",
"ivolve-private-subnet", "ivolve-private-RT", ]


#####################[EC2]#####################
ami_id        = "ami-08b5b3a93ed654d19"
instance_type = "t2.micro"
key_name      = "mykey"
private_key = "mykey.pem"
instance_name = ["ivolve-public-ec2", "ivolve-private-ec2"]


#####################[Security Group sg]#####################
security_groups = [
  {
    name        = "sg_public_ec2"
    description = "Security group for Nginx Instance"
    ingress = [
      { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
  },
  {
    name        = "sg_private_ec2"
    description = "Security group for Apache(httpd) Instance"
    ingress = [
      { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress = [
      { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
  }
]


variable "region" {
  type = string
}

#####################[VPC]#####################
variable "cidr" {
  type = list
}
variable "resource_name" {
  type = list
}
#####################[Subnet]#####################
variable "subnets" {
  type = map(object({
    cidr_block = string
    az         = string
    is_public  = bool
  }))

  default = {
    Public  = { cidr_block = "10.0.0.0/24", az = "us-east-1a", is_public = true }
    Private = { cidr_block = "10.0.1.0/24", az = "us-east-1b", is_public = false }
  }
}


#####################[EC2]#####################
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "private_key" {
  type = string
}
variable "instance_name" {
  type = list
}
#####################[ Dynamic Security Group sg]#####################
variable "security_groups" {
  type = list(object({
    name        = string
    description = string

    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
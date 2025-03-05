variable "region" {
  default = "us-east-1"
}


variable "AZs" {
  default = ["us-east-1a", "us-east-1b"]
}

#####################[ EC2 ]#####################
variable "ami" {
  default = "ami-05b10e08d247fb927"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "instance_name" {
  default = "EC2-Instance"
}
variable "private_key" {
  default = "mykey"
}
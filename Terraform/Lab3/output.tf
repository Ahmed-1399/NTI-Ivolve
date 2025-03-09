#####################[ Public, Private "IP" for Public Instance ]#####################

output "public_ip_for_ivolve_public_sub_ec2" {
  value = aws_instance.ivolve_public_sub_ec2.public_ip
}
output "private_ip_for_ivolve_public_sub_ec2" {
  value = aws_instance.ivolve_public_sub_ec2.private_ip
}

#####################[ Private "IP" for Private Instance ]#####################
output "private_ip_for_ivolve_private_sub_ec2" {
  value = aws_instance.ivolve_Private_sub_ec2.private_ip
}
# Lab1
![Architectire](./assets/Lab1.png)


## Create VPC-Manually & Attach IGW to it
![Architectire](./assets/manual-VPC.png)


# Import VPC
```bash
to import VPC ---> get of VPV-ID

terraform init   ----> Install Plugins

terraform import aws_vpc.ivolve_vpc vpc-0f919e3c6a28014c7
terraform import aws_internet_gateway.ivolve_IGW igw-069c3bd4e4c449c61

terraform state list  ----->  List Resources
terraform show        ----->  Extract Configuration 

```
##
![Architectire](./assets/import-VPC.png)


# Check Changes
```bash
After "Extract Configuration" Copy it & add it in "main.tf" then write..

terraform plan    ----->  to ensure that there isn't any changes
```

# Apply
```bash

# Display "every things" that "will be building before building it"
terraform plan

# build Infrastructure
terraform apply -auto-approve

```

##
![Architectire](./assets/check-changes.png)


# Output
##
![Architectire](./assets/Output.png)

# VPC-Output
##
![Architectire](./assets/VPC-Output.png)

# SG-Output
##
![Architectire](./assets/SG-Output.png)

# EC2-Output
##
![Architectire](./assets/EC2-Output.png)

# RDS-Output
##
![Architectire](./assets/RDS-Output.png)


# Destroy
```bash
# After finished don't forget to destroy infrastructure
terraform destroy -auto-approve
```
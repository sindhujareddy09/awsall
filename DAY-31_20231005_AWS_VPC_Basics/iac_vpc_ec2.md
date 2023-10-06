# Versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# VPC
# VPC
resource "aws_vpc" "cloudbinary" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name      = "cloudbinary_VPC"
    CreatedBy = "iac - terraform"
  }
}

# Subnets - 8 ( 2 Public, 6 Private )

# Subnet - Public-1 
resource "aws_subnet" "cloudbinary_public_subnet_1" {
  vpc_id                  = aws_vpc.cloudbinary.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name      = "cloudbinary_public_subnet_1"
    CreatedBy = "iac - terraform"
  }

}

# IGW

# RTB - 1 Public and 1 Private

# Allow IGW to Public RTB

# Create NAT Gateway 

# Allow Nat Gateway in Private RTB

# Allow 2 Public Subnets in Public RTB

# Allow 6 Private Subnets in Private RTB

# Create NACL 

# Create Security Group for Basion

# Create Security Group for Web Servers

# Create Security Group for App Servers

# Create Security Group for DB Servers

# Create Bastion Server

# Create Web Servers

# Create App Servers

# Create DB Servers





# Resource
resource "aws_instance" "dev" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = ["sg-077fced5d5205d41f"]
  iam_instance_profile   = var.iam_instance_profile
  #user_data              = file("/Users/ck/repos/iac-terraform/iac/web.sh")
  user_data = <<-EOF
  #!/bin/bash
  echo "Welcome To Terraform" > /tmp/user_data.log
  EOF

  tags = {
    Name        = "Dev Instance"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}

# Outputs
# output "ami" {
#   value = aws_instance.dev.ami
# }
# output "public_ip" {
#   value = aws_instance.dev.public_ip
# }
# output "private_ip" {
#   value = aws_instance.dev.private_ip
# }

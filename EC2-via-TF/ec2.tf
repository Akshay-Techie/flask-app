# ---------------------------------------------------------
# Provider configuration
# ---------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"   # Change region as per your requirement
}

# ---------------------------------------------------------
# Security Group - allow SSH, HTTP, HTTPS
# ---------------------------------------------------------
resource "aws_security_group" "web_sg" {
  name        = "allow_web"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Reference your existing IAM role by name
resource "aws_iam_instance_profile" "existing_profile" {
  name = "EC2-ECR-ReadOnly-Profile"   # You can give this any name
  role = "EC2-ECR-ReadOnly"           # <-- Replace with the exact name of your IAM role created in console
}

# Attach the instance profile to your EC2 instance
resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-019715e0d74f695be"   # Ubuntu 22.04 LTS AMI
  instance_type = "t3.micro"
  key_name      = "Genexis-Key-Pair"   # Use existing key
  security_groups = [aws_security_group.web_sg.name]

  # Attach the IAM role (via instance profile) so this EC2 can access AWS services like ECR
  iam_instance_profile = aws_iam_instance_profile.existing_profile.name

  tags = {
    Name = "Ubuntu-Server"
  }
}

# ---------------------------------------------------------
# Outputs - show public IPs for SSH/HTTP/HTTPS connection
# ---------------------------------------------------------
output "ubuntu_public_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}
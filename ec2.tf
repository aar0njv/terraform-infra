/*
- This Terraform EC2 configuration specifies required tf version and aws provider,
  configures it and create an ec2 instance 
- The variable values are managed through var.tf file.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region
}

resource "aws_instance" "tf_ec2_server" {
  ami           = var.image
  instance_type = var.type
  tags = {
  Name = var.tag
  }
}

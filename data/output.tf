/*
- Retrieves info from an existing S3 bucket and display the info as terraform output
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
  region  = "ap-south-1"
}
output "bucket_id" {
  value = data.aws_s3_bucket.existing_bucket.id
}
output "bucket_arn" {
  value = data.aws_s3_bucket.existing_bucket.arn
}
output "bucket_region" {
  value = data.aws_s3_bucket.existing_bucket.region
}
output "bucket_domain_name" {
  value = data.aws_s3_bucket.existing_bucket.bucket_domain_name
}

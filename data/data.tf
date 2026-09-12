/*
Fetching data from aleady existing resource in the infra
*/
data "aws_s3_bucket" "existing_bucket" {
  bucket = "existing_bucket_name"
}

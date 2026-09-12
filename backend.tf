/*
- used to store the .tfstate file in a centralized location so that team members can access the same state
- .tfstate is a state file which stores and keep track of the current state of the managed infrastructure
*/


terraform {
backend "s3" {
  bucket = "s3-bucket-name"
  key    = "remote.tfstate"
  region = "eu-north-1"
  encrypt = "true"
 }
}

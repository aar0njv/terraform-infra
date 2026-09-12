variable "region" {
  type = string
  default = "eu-north-1"
}
variable "type" {
  type = string
  default = "t3.micro"
}
variable "tag" {
  type = string
  default = "tf_ec2_server"
}
variable "image" {
  type = string
  default = "ami-051c6296b8d2535f1"
}

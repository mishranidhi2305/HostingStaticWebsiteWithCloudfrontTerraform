// variable files, so that the code can we loosetly coupled and more reusable.

variable "environment" {
    default     = "dev" 
}

variable "customer" {
    default = "nidhi" 
}

variable "name" {
    default = "terraform"
  
}

locals {
    s3_origin_id = "s3-${aws_s3_bucket.my_bucket.id}"
}
variable "region" {
    default = "ap-south-1"
  
}
variable "allowed_countries" {
    type    = list(string)
    default = ["US", "IN"]
  
}
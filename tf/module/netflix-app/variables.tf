variable "aws_region" {
   description = "region"
   type        = string
}
variable "vpc_cidr" {
   description = "vpc_cidr"
   type        = string
}
variable "subnet_cidr_private" {
   description = "subnet_cidr"
   type        = string
}
variable "subnet_cidr_public" {
   description = "subnet_cidr"
   type        = string
}

variable "availability_zone" {
   description = "availability_zone"
   type        = list(string)
}
variable "ami_id" {
   description = "ami_id"
   type        = string
}
variable "instance_type" {
   description = "instance_type"
   type        = string
}
variable "key_name" {
   description = "key_name"
   type        = string
}






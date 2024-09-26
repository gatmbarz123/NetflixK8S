variable "env" {
   description = "Deployment environment"
   type        = string
}

variable "region" {
   description = "AWS region"
   type        = string
}

variable "ami_id" {
   description = "EC2 Ubuntu AMI"
   type        = string
}

variable "instance_type" {
   description = "EC2 Type"
   type        = string
}

variable "az" {
   description = "EC2 AZ"
   type        = string
}

variable "key_pairs" {
   description = "EC2 key"
   type        = string
}

variable "bucket" {
   description = "S3-BUCKET"
   type        = string
}


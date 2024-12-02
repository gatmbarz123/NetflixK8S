terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.55"
    }
  }

   backend "s3" {
    bucket = "terraform.bar"
    key    = "tfstate.json"
    region = "eu-north-1"
  
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region  = var.region 
}

module "netflix_app" {
  source = "./module/netflix-app"

  aws_region         = var.region
  ami_id             = data.aws_ami.ubuntu_ami.id 
  vpc_cidr           = "10.0.0.0/16"
  subnet_cidr_private = "10.0.1.0/24"
  subnet_cidr_public = "10.0.2.0/24"
  availability_zone  = data.aws_availability_zones.available_azs.names
  instance_type      = var.instance_type
  key_name           = var.key_pairs
}






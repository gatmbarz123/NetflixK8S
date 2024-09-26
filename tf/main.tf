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

resource "aws_instance" "netflix_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.netflix_app_sg.name]
  key_name  =   var.key_pairs
  depends_on =  [aws_s3_bucket.netflix_s3]
  availability_zone = var.az
  user_data = file("docker_image_terraform.sh")

  tags = {
    Name = "terraform-server-${var.env}"
  }
}

resource "aws_security_group" "netflix_app_sg" {
  name        = "terraform-netflix-app-sg"   
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_ebs_volume" "netflix_ebs" {
  availability_zone = var.az
  size              = 1

  tags = {
    Name = "TerraformEBS-${var.env}"
  }
}

resource "aws_volume_attachment" "netflix_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.netflix_ebs.id
  instance_id = aws_instance.netflix_app.id
}

resource "aws_s3_bucket" "netflix_s3" {
  bucket = var.bucket

  tags = {
    Name = "Terrafom-Netflix-${var.env}"
  }
}


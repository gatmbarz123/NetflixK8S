terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.55"
    }
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region  = "eu-north-1"
  profile = "default"  
}

resource "aws_instance" "netflix_app" {
  ami           = "ami-04cdc91e49cb06165"
  instance_type = "t3.micro"
  security_groups = [aws_security_group.netflix_app_sg.name]
  key_name  =   aws_key_pair.netflix_key_pair.key_name
  depends_on =  [aws_s3_bucket.netflix_s3]
  user_data = file("~/Desktop/docker_image_terraform.sh")

  tags = {
    Name = "terraform-server"
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

resource "aws_key_pair" "netflix_key_pair" {
  key_name   = "my-generated-key-pair"
  public_key = file("~/Desktop/Keys/terraform.pub")
}

resource "aws_ebs_volume" "netflix_ebs" {
  availability_zone = "eu-north-1b"
  size              = 1

  tags = {
    Name = "TerraformEBS"
  }
}

resource "aws_volume_attachment" "netflix_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.netflix_ebs.id
  instance_id = aws_instance.netflix_app.id
}

resource "aws_s3_bucket" "netflix_s3" {
  bucket = "terraform-bar-bucket"

  tags = {
    Name        = "Terrafom-Netflix"
    Environment = "Dev"
  }
}


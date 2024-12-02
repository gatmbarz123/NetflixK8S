resource "aws_instance" "netflix_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.netflix_app_sg.id]
  key_name  =   var.key_name
  user_data = templatefile("./module/netflix-app/deploy.sh",{ ip_private = aws_instance.netflix_catalog.private_ip })
  subnet_id = module.netflix_app_vpc.public_subnets[0]
  tags = {
    Name = "netflix_app"
  }
  depends_on = [aws_instance.netflix_catalog]
}

resource "aws_instance" "netflix_catalog" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.netflix_app_sg_catlog.id]
  key_name  =   var.key_name
  user_data = file("./module/netflix-app/deploy_catlog.sh")
  subnet_id = module.netflix_app_vpc.public_subnets[0]
  tags = {
    Name = "netflix_catalog"
  }
}

resource "aws_security_group" "netflix_app_sg" {
  name        = "terraform-netflix-app-sg"   
  description = "Allow SSH and HTTP traffic"
  vpc_id      = module.netflix_app_vpc.vpc_id

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
  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_security_group" "netflix_app_sg_catlog" {
  name        = "terraform-netflix-app-sg_catlog"   
  description = "Allow SSH and HTTP traffic"
  vpc_id      = module.netflix_app_vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

module "netflix_app_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "Netflix_app"
  cidr = var.vpc_cidr
  map_public_ip_on_launch = true

  azs             = var.availability_zone
  public_subnets  = [var.subnet_cidr_public]

  enable_nat_gateway = false

}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_key_pair" "deployer" {
  key_name   = "futuref-key"
  public_key = file("~/.ssh/my-key.pub")
}

provider "aws" {
  region  = "us-west-2"
}
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ff" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  key_name = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_ssh.name]

    tags = {
    Name = "FutureFocus"
    
}

}
output "instance_public_ip" {
  value = aws_instance.ff.public_ip
}



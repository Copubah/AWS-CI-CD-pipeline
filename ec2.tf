provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

variable "key_name" {
  description = "The name of the existing AWS Key Pair to use for EC2 instance"
  type        = string
}

variable "my_ip" {
  description = "Your public IP to allow SSH access"
  type        = string
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere"
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

resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 in us-east-1, update if using different region
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = {
    Name = "Terraform-NodeJS-App"
  }
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app_server.public_dns
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "shuup_instance" {
  ami           = "ami-0705384c0b33c194c" # Ubuntu Amazon Machine Image
  instance_type = "t3.micro"
  key_name      = "sre-final-project"
  security_groups = ["default"]

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y git docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

git clone https://github.com/nyrtal/sre-project.git
cd sre-project

# Start Shuup using Docker Compose
sudo docker-compose up -d
EOF

  tags = {
    Name = "ShuupInstance"
  }
}

output "instance_ip" {
  value = aws_instance.shuup_instance.public_ip
}
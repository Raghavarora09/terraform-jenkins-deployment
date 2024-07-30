provider "aws" {
  region     = "ap-south-1"
  access_key = "**********"   #replace with your access key
  secret_key = "**********"   #replace with your secret key  
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c2af51e265bd5e0e" 
  instance_type = "t2.medium"

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install openjdk-11-jdk -y
              wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt update -y
              sudo apt install jenkins -y
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF

  tags = {
    Name = "Jenkins Server"
  }

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  key_name = "terraform"  # Replace with your key pair name
}

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "jenkins-sg"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

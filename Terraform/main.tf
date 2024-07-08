resource "aws_instance" "apiServer" {
  ami           = "ami-04a81a99f5ec58529"   #ubuntu AMI
  instance_type = "t2.micro"
  tags = {
    Name = "Api server Project"
  }
  user_data              = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo snap install docker
        sudo systemctl start docker
        sudo apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common wget sudo git
        sudo docker pull yit1977ltld/apiproject:latest
        sudo docker run -d --name api -p 5000:5000 yit1977ltld/apiproject:latest
  EOF

  key_name               = "Devops"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]
}

resource "aws_security_group" "ssh-sg" {
  name        = "ssh-access + TCP (5000+80)"
  description = "allow ssh and TCP access"
  ingress {
    from_port   = 22
    to_port     = 22
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
    from_port   = 5000
    to_port     = 5000
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

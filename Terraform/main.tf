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
  EOF

  provisioner "remote-exec" {
    inline = ["sudo docker run -p 80:8080 -p 50000:50000 -d jenkins/jenkins" ]
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file("c:/Users/yonis/downloads/Devops.pem")
  }

  key_name               = "Devops"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]
}

resource "aws_security_group" "ssh-sg" {
  name        = "ssh-access"
  description = "allow ssh access"
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

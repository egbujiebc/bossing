resource "aws_instance" "demo_instance" {
  ami                    = "ami-06e46074ae430fba6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.demo.id]
  
  tags = {
    Name = "demo_instance"
  }
}



resource "aws_ebs_volume" "demo" {
  availability_zone = "us-east-1b"
  size              = 8

  tags = {
    Name = "demo_ebs"
  }
}
terrrr
resource "aws_volume_attachment" "demoebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.demo.id
  instance_id = aws_instance.demo_instance.id
}

resource "aws_security_group" "demo" {
  name = "demo_security"
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

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "my-ec2" {
  ami                     = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id = aws_subnet.my-public-subnet.id
  instance_type           = "t2.micro" 
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.my-ec2-sg.id]
  user_data       = <<-EOF
              #!/bin/bash
              # Update the package index
              sudo yum update -y
              # Install Nginx
              sudo amazon-linux-extras enable nginx1.12
              sudo yum install -y nginx
              # Start Nginx
              sudo systemctl start nginx
              # Enable Nginx to start on boot
              sudo systemctl enable nginx
              EOF
    tags = {
      name = "my-ec2-instance"
    }
}

resource "aws_eip" "my-eip" {
  instance = aws_instance.my-ec2.id
}

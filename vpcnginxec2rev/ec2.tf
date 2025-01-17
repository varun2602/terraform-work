data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "c6a.2xlarge"
  subnet_id     = aws_subnet.my-public-subnet.id
  security_groups = [ aws_security_group.my-ec2-sg.id ]
  associate_public_ip_address =  true
  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  user_data = <<-EOF
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
    Name = "tf-example"
  }
}

resource "aws_eip" "my-eip" {
  instance = aws_instance.my-ec2.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

#   filters = {
#     name = "ubuntu/images/*/x86_64/generic-amd64*"
#   }
}
resource "aws_instance" "nginxserver" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.nano"
  subnet_id = aws_subnet.my-public-subnet.id
  user_data = <<-EOF
     #!/bin/bash
     sudo apt update -y
     sudo apt install nginx -y
     sudo systemctl start nginx
     sudo systemctl enable nginx
     EOF
#   host_resource_group_arn = "arn:aws:resource-groups:us-west-2:123456789012:group/win-testhost"
#   tenancy                 = "host"
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    associate_public_ip_address = true
  tags = {
    Name = "NginxServer"
  }
}
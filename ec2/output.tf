output "aws_instance_public_ip" {
  value = aws_instance.myec2server.public_ip
}
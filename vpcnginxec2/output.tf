output "instance_public_ip" {
  description = "Public ip address of the EC2 instance"
  value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
  description = "Url of the EC2 instance"
  value = "https://${aws_instance.nginxserver.public_ip}"
}
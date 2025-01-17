output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my-ec2.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.my-eip.public_ip
}

output "instance_url" {
  description = "URL of the instance"
  value = "http://${aws_eip.my-eip.public_ip}"
}

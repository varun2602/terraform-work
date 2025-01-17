output "ec2_global_ips" {
  value = [aws_eip.my-eip.public_ip]
}

output "ec2_urls" {
  value = ["http://${aws_eip.my-eip.public_ip}"]
}

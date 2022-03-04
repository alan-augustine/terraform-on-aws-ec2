output "instance_publicip" {
  value = aws_instance.myec2vm.public_ip
  description = "EC2 Instance public IP"
}

output "instance_publicdns" {
  value = aws_instance.myec2vm.public_dns
  description = "EC2 Instance public DNS"
}
# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip 
}

# Private EC2 Instances
## ec2_private_instance_ids
# App1
output "app1_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for i in module.ec2_private_app1: i.id]
}
## ec2_private_ip
output "app1_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for i in module.ec2_private_app1: i.private_ip]
}

# App2
output "app2_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for i in module.ec2_private_app2: i.id]
}
## ec2_private_ip
output "app2_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for i in module.ec2_private_app2: i.private_ip]
}

# App3
output "app3_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for i in module.ec2_private_app3: i.id]
}
## ec2_private_ip
output "app3_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for i in module.ec2_private_app3: i.private_ip]
}
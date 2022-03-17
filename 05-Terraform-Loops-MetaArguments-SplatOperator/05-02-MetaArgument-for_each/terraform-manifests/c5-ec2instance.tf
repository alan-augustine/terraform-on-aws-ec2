# Availability zone data source 
data "aws_availability_zones" "my_azones" {
  # Only Availability Zones (no Local Zones):
  # Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#by-filter
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]    
  }
  
}

# EC2 Instance - create one instance in each AZ
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  security_groups = [aws_security_group.vpc-ssh.name, aws_security_group.vpc-web.name]
  # for_each accepts only set or map as input
  for_each = toset(data.aws_availability_zones.my_azones.names)
  # You can also use each.value because for toset(list) , each.key == each.value
  availability_zone = each.key
  tags = {
    Name = "Instance-${each.key}"
  }
}
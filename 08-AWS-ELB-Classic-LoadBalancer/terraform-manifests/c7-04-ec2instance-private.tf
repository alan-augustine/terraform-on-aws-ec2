
# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"

  # copied from https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest#single-ec2-instance
  # var.environment - from c2-generic-variables.tf
  name = "${var.environment}-Private-${each.key}"

  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.private_sg.security_group_id]
  
  #create EC2 instances in public subnets
  
  # Below commented out code was not working
  #for_each               = toset(module.vpc.public_subnets)
  #subnet_id              = each.key
  for_each               = toset(["0", "1"])
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))

  tags = local.common_tags
  # instance_count = var.private_instance_count : this is not supported in new versions
  user_data = file("${path.module}/app1-install.sh")

  # Since we need connectivity to internet via NAT Gateway to run , wait for NAT gateway (wait for VPC creation to be completed)
  depends_on = [module.vpc]

}

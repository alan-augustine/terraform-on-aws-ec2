# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"

  # copied from https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest#single-ec2-instance
  # var.environment - from c2-generic-variables.tf
  name = "${var.environment}-BastionHost"

  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  #any public subnets
  subnet_id              = module.vpc.public_subnets[0]

  tags = local.common_tags
  # Since we need connectivity to internet via NAT Gateway to run 
  # instance_count = var.private_instance_count : this is not supported in new versions
  user_data = file("${path.module}/app1-install.sh")
  depends_on = [module.vpc]

}

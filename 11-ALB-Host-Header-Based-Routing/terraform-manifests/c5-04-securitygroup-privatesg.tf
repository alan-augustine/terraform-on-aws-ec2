
# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
# Allow HTTPS & SSH from within VPC - this allows port 80 communication from load banacer to EC2 instance in private subnets
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "private-sg"
  description = "Security group for HTTP & SSH port open for entire VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]

  egress_rules = ["all-all"]

  tags = local.common_tags

}
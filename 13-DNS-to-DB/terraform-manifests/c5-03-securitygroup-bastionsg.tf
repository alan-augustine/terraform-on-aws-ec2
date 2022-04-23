module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "public-bastion-sg"
  description = "Security group for SSH"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  # there are a set of pre-defined rules
  ingress_rules       = ["ssh-tcp"]

  egress_rules = ["all-all"]

  tags = local.common_tags

}
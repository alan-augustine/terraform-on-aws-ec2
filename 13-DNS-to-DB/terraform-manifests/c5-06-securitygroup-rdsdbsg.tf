module "rdsdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "rdsdb-sg"
  description = "Access to MySQl RDs DB from entire VPC CIDR block"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"  
      description = "MySQL Access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]
# All outbound connection allowed
  egress_rules = ["all-all"]
  tags = local.common_tags

}
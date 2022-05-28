# classic load balancer
module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "loadbalancer-sg"
  description = "Security group for HTTP from internet"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  # there are a set of pre-defined rules
  ingress_rules       = ["http-80-tcp" , "https-443-tcp"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6           # TCP
      description = "Port 81"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # note: Private EC2 instance SG will allow all connection from elements within VPC
  egress_rules = ["all-all"]

  tags = local.common_tags

}
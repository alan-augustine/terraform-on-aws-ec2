# we can give whatever name we like eg: module "myvpc" {...}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.13.0"

  # VPC Basic details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database subnets
  create_database_subnet_group = true 
  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"]
  # create_database_nat_gateway_route = false
  # create_database_internet_gateway_route = false

  # NAT Gateway for outbound internet communication
  enable_nat_gateway = true
  # we just one NAT Gateway for all AZs, to reduce cost (not one NAT Gateway per AZ)
  single_nat_gateway = true 

  # DNS parameters
  enable_dns_hostnames = true 
  enable_dns_support   = true

  tags ={
      Owner = "Alan"
      Environment = "dev"
  }
  vpc_tags = {
      Name = "vpc-dev"
  }
  private_subnet_tags = {
      Name = "private-subnets"
  }
  public_subnet_tags = {
      Name = "public-subnets"
  }
  database_subnet_tags = {
      Name = "database-subnets"
  }

}
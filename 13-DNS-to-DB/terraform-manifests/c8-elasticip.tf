resource "aws_eip" "bastion_eip" {
  instance = module.ec2_public.id
  vpc      = true
  # EIP may require IGW to exist prior to association. Use depends_on to set an explicit dependency on the IGW.
  # Wait for all VPC resources to be created
  depends_on = [module.ec2_public, module.vpc.igw_id]
  tags = local.common_tags
}
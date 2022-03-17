resource "aws_instance" "my_instance" {
    ami               = data.aws_ami.ami_amazon_linux2.id
    instance_type     = var.aws_instance_type["prod"]
    key_name          = var.aws_key_pair
    security_groups   = [aws_security_group.vpc-ssh.name, aws_security_group.vpc-web.name]
    user_data         = file("${path.module}/app1-install.sh")
    for_each          = toset([ for region, details in  data.aws_ec2_instance_type_offerings.instance_types_offerings_in_az: region if length(details.instance_types) != 0])
    availability_zone = each.key
    tags = {
      "Name" = each.key
    }
} 
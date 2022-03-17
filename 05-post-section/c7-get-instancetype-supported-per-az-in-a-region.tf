data "aws_availability_zones" "my_azones" {
    filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }   
  
}

# DEBUG - to study and understand the output
output "DEBUG_data_aws_availability_zones_my_azones" {
  description = "DEBUG_data_aws_availability_zones_my_azones"
  value = data.aws_availability_zones.my_azones
  
}

#DEBUG - to study and understand the output
output "DEBUG_data_aws_availability_zones_my_azones_names" {
  description = "DEBUG_data_aws_availability_zones_my_azones_names"
  value = data.aws_availability_zones.my_azones.names
  
}

data "aws_ec2_instance_type_offerings" "instance_types_offerings_in_az" {
  # for_racj accepts only maps or sets as input
  for_each = toset(data.aws_availability_zones.my_azones.names)
  filter {
    name   = "instance-type"
    # As per below Ref, 'values' is a list of strings
    # Ref: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstanceTypeOfferings.html
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}

# DEBUG - to study and understand the output
output "DEBUG_data_aws_ec2_instance_type_offerings_instance_types_offerings_in_az" {
  description = "DEBUG_data_aws_ec2_instance_type_offerings_instance_types_offerings_in_az"
  value = data.aws_ec2_instance_type_offerings.instance_types_offerings_in_az
  
}

# DEBUG - to study and understand the output
output "DEBUG_azs_with_t3_micro" {
  description = "Availability Zones with t3.micro in our Region"
  value = [ for region, details in  data.aws_ec2_instance_type_offerings.instance_types_offerings_in_az: region if length(details.instance_types) != 0]
  
}


#output "azs_with_t3_micro_keys" {
#  description = "Availability Zones with t3.micro in our Region"
#  value = keys(data.aws_ec2_instance_type_offerings.instance_types_offerings_in_az)
#  
#}
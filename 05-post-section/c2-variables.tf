variable "aws_region" {
    type = string
    description = "Default AWS Region"
    default = "us-east-1"  
}

variable "aws_instance_type" {
    type = map(string)
    description = "default instance type"

    default = {
        "dev"  = "t3.micro"
        "test" = "t3.micro"
        "prod" = "t3.micro"
    } 
}

variable "aws_key_pair" {
  type = string
  description = "AWS Keypair for SSH"
  default = "terraform-key"
}

# DEBUG Output -----------------------------------------------

output "DEBUG_aws_region" {
  description = "DEBUG_aws_region"
  value = var.aws_region
}

output "DEBUG_aws_instance_type" {
  description = "DEBUG_aws_instance_type"
  value = var.aws_instance_type
}

output "DEBUG_aws_key_pair" {
  description = "DEBUG_aws_key_pair"
  value = var.aws_key_pair
}


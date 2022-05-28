# Terraform Block
terraform {
  required_version = "~> 1.1" # Means 1.1, 1.2, 1.3 etc. , but not 2.0 or 1.0
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.3"
    }  
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

## AWS Bug for SNS Topic: https://stackoverflow.com/questions/62694223/cloudwatch-alarm-pending-confirmation
# Due to above issue, we created random resource
resource "random_pet" "this" {
  length = 2
}
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
